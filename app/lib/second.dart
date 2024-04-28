import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:http/http.dart' as http;
import 'dart:convert'; // Add this line at the top of your file
import 'dart:async'; // Import the dart:async package

void getTelephonyManager() {
  const AndroidIntent intent = AndroidIntent(
    action: 'action_view',
  );
  intent.launch();
}

class CellInfo {
  static const platform = MethodChannel('com.example.cellinfo/cellinfo');

  static Future<String> getCellInfo() async {
    try {
      final String result = await platform.invokeMethod('getCellInfo');
      final List<String> cellInfoList = result.split('\n');
      print(result);
      // Create a map with the correct keys and values
      print(cellInfoList);
      final Map<String, dynamic> cellInfoMap = {
        'date_and_time':
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        'operator': 'OperatorName',
        'signal_power': '100',
        'SNR': '10.0',
        'network_type': '4G',
        'ip': '192.168.1.1',
        'mac': '00:0a:95:9d:68:16',
      };

      for (var item in cellInfoList) {
        if (item.contains(': ')) {
          var splitItem = item.split(': ');
          if (splitItem.length == 2) {
            var key = splitItem[0].replaceAll(' ', '_').toLowerCase();
            var value = splitItem[1];
            if (cellInfoMap.containsKey(key)) {
              cellInfoMap[key] = value;
            }
          }
        }
      }
      print(cellInfoList);
      //print(cellInfoMap);
      if (cellInfoList.length < 6) {
        throw Exception('getCellInfo() returned too few values');
      }

      // Try to send the data every 10 seconds
      Timer.periodic(const Duration(seconds: 10), (Timer t) async {
        try {
          // Send the data to the server
          final response = await http.post(
            Uri.parse('http://10.0.2.2:8000/networkentry/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(cellInfoMap),
          );
          if (response.statusCode == 201) {
            // If the server returns a 201 CREATED response, then print a success message.
            print('Data sent successfully');
          }
        } catch (e) {
          // If an error occurs, log the error and try again after 10 seconds.
          print('Failed to send data to server: $e');
        }
      });

      return result;
    } on PlatformException catch (e) {
      return "Failed to get cell info: '${e.message}'.";
    }
  }
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});
  final String analysisResult = 'Your analysis result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Results'),
      ),
      body: FutureBuilder<String>(
        future: CellInfo.getCellInfo(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.split('\n') ?? [];
            //sendNetworkEntry(data);

            return GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFF44ABFF),
                  child: Text(' ${data.length > 1 ? data[1] : 'N/A'}'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFf44ABFF),
                  child: Text(' ${data.length > 6 ? data[6] : 'N/A'}'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFf44ABFF),
                  child: Text(' ${data.length > 2 ? data[2] : 'N/A'}'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFf44ABFF),
                  child: Text(' ${data.isNotEmpty ? data[0] : 'N/A'}'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFf44ABFF),
                  child: Text(' ${data.length > 3 ? data[3] : 'N/A'}'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFf44ABFF),
                  child: Text(' ${data.length > 4 ? data[4] : 'N/A'}'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFf44ABFF),
                  child: Text(' ${data.length > 5 ? data[5] : 'N/A'}'),
                ),
                // Removed the erroneous line
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


/*
Future<void> sendNetworkEntry(List<String> data) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/networkentry'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'data': data.join('\n'),
    }),
  );

  if (response.statusCode == 200) {
    print('Data sent successfully');
  } else {
    throw Exception('Failed to send data');
  }
}*/
