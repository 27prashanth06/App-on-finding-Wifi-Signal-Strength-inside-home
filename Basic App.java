import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WiFi Strength App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  int signalStrength = await WiFiForIoTPlugin.wifiLevel;
                  print('Signal Strength: $signalStrength');
                  // Display signal strength or perform other actions
                },
                child: Text('Check WiFi Strength'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
