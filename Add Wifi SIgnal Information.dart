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
  Set<Heatmap> _heatmaps = {};

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
          // You can add custom code here after the map is created
        },
        heatmaps: _heatmaps,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addManualData,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addHeatmap(List<WeightedLatLng> data) {
    final Heatmap heatmapLayer = Heatmap(
      heatmapId: HeatmapId('heatmap'),
      points: data,
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

  void _addManualData() async {
    TextEditingController latitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();
    TextEditingController intensityController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add WiFi Signal Strength Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: latitudeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: longitudeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
              TextField(
                controller: intensityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Signal Intensity'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                double latitude = double.parse(latitudeController.text);
                double longitude = double.parse(longitudeController.text);
                double intensity = double.parse(intensityController.text);

                _addHeatmap([WeightedLatLng(point: LatLng(latitude, longitude), intensity: intensity)]);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
