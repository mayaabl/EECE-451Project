import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  Map<String, dynamic>? _averageConnectivityTime;
  Map<String, dynamic>? _averageSignalPowerDevice;
  Map<String, dynamic>? _averageSignalPowerNetwork;
  Map<String, dynamic>? _averageConnectivityOperator;
  Map<String, dynamic>? _averageSNR;
  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  String? _macAddress;
  String? _ipAddress;

  @override
  void initState() {
    super.initState();
    _getNetworkInfo();
  }

  Future<void> _getNetworkInfo() async {
    String? macAddress = await WifiInfo().getWifiBSSID();
    print(macAddress);
    String? ipAddress;
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/ip_address'));
      if (response.statusCode == 200) {
        ipAddress = response.body;
      } else {
        print('Failed to get IP address: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to get IP address: $e');
    }
    setState(() {
      _macAddress = macAddress;
      _ipAddress = ipAddress;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
      if (_startDate != null && _endDate != null) {
        _fetchOperatorAverage();
        _fetchNTypeAverage();
        _fetchPowerNType();
        _fetchPowerDevice();
        _fetchSNRAverage();
      }
    }
  }

  Future<void> _fetchOperatorAverage() async {
    _fetchData('operator_average', (data) {
      setState(() {
        _averageConnectivityOperator = data;
      });
    });
  }

  Future<void> _fetchNTypeAverage() async {
    _fetchData('ntype_average', (data) {
      setState(() {
        _averageConnectivityTime = data;
      });
    });
  }

  Future<void> _fetchPowerNType() async {
    _fetchData('power_ntype', (data) {
      setState(() {
        _averageSignalPowerNetwork = data;
      });
    });
  }

  Future<void> _fetchPowerDevice() async {
    _fetchData('power_device', (data) {
      setState(() {
        _averageSignalPowerDevice = data;
      });
    });
  }

  Future<void> _fetchSNRAverage() async {
    _fetchData('SNR_average', (data) {
      setState(() {
        _averageSNR = data;
      });
    });
  }

  Future<void> _fetchData(String endpoint, Function callback) async {
    print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
    print(_startDate);
    print(_endDate);
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/$endpoint/?start_date=${_dateFormatter.format(_startDate!)}&end_date=${_dateFormatter.format(_endDate!)}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        callback(data);
      } else {
        print('Failed to fetch $endpoint: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch $endpoint: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Text('MAC Address: $_macAddress'),
                Text('IP Address: $_ipAddress'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(_startDate == null
                          ? 'Select start date'
                          : 'Start Date: ${_dateFormatter.format(_startDate!)}'),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(_endDate == null
                          ? 'Select end date'
                          : 'End Date: ${_dateFormatter.format(_endDate!)}'),
                    ),
                  ],
                ),
                const Text(
                  "Analysis Results",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Text(
                                "Average Connectivity Time per Network Type: "),
                            Text((_averageConnectivityTime ?? 'Loading...')
                                .toString())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Repeat for other cards as initially designed
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Average Signal Power per device: "),
                            Text((_averageSignalPowerDevice ?? 'Loading...')
                                .toString())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                                "Average Signal Power per Network Type: "),
                            Text((_averageSignalPowerNetwork ?? 'Loading...')
                                .toString())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                                "Average Connectivity time per operator: "),
                            Text((_averageConnectivityOperator ?? 'Loading...')
                                .toString())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Average SNR: "),
                            Text((_averageSNR ?? 'Loading...').toString())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
