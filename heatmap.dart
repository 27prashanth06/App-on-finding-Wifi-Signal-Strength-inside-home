import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyMap(),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Heatmap> _heatmaps = {};

  @override
  void initState() {
    super.initState();
    _generateRandomHeatmapData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WiFi Signal Strength Heatmap'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(YourInitialLatitude, YourInitialLongitude),
          zoom: YourInitialZoomLevel,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        heatmaps: _heatmaps,
      ),
    );
  }

  void _generateRandomHeatmapData() {
    final Random random = Random();
    List<WeightedLatLng> heatmapData = [];

    for (int i = 0; i < 100; i++) {
      final double lat = YourRandomLatitude; // Replace with actual latitude data
      final double lng = YourRandomLongitude; // Replace with actual longitude data
      final double signalStrength = random.nextDouble() * 100; // Replace with actual signal strength data
      heatmapData.add(WeightedLatLng(
        point: LatLng(lat, lng),
        intensity: signalStrength,
      ));
    }

    final Heatmap heatmapLayer = Heatmap(
      heatmapId: HeatmapId('heatmap'),
      points: heatmapData,
      radius: 20,
      opacity: 0.6,
      gradient: HeatmapGradient(
        colors: <Color>[
          Colors.green,
          Colors.red,
        ],
        startPoints: <double>[0.2, 1.0],
      ),
    );

    setState(() {
      _heatmaps.add(heatmapLayer);
    });
  }
}
