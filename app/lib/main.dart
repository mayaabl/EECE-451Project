import 'package:flutter/material.dart';
import 'package:frontend451/second.dart';
import 'package:frontend451/third.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromARGB(255, 145, 163, 255),
                Color.fromARGB(255, 228, 77, 208)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://pnghq.com/wp-content/uploads/network-png-transparent-image-download-56785.png",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: 200,
                ),
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    "Welcome to Network Cell Analyzer",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp3(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_right_alt_outlined),
                  label: const Text('Analyze Network'),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.history_sharp),
                  label: const Text('View History'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
