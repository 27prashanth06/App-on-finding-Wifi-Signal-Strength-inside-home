import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _signalStrength = 0;

  @override
  void initState() {
    super.initState();

    // Start monitoring WiFi signal strength
    WiFiForIoTPlugin.onWiFiSignalChanged.listen((event) {
      setState(() {
        _signalStrength = event.signalLevel;
      });
    });
  }

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
              Text(
                'Signal Strength: $_signalStrength',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              LinearProgressIndicator(
                value: _signalStrength / 100,
                minHeight: 10,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getSignalStrengthColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSignalStrengthColor() {
    if (_signalStrength >= 70) {
      return Colors.green;
    } else if (_signalStrength >= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
