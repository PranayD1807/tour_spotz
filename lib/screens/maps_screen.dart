import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';
// import 'package:location/location.dart';
// import 'package:path/path.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
// import 'package:tour_spotz/helpers/location_helper.dart';
import 'package:tour_spotz/models/place.dart';

class MapScreen extends StatefulWidget {
  // const MapScreen({Key? key}) : super(key: key);
  final PlaceLocation initialLocation;
  final bool isSelecting;
  // final LocationData userLocation;
  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 0,
      longitude: 0,
      address: '',
    ),
    this.isSelecting = false,
    // required this.userLocation,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final locData = Location().getLocation();

  latlng.LatLng _pickedLocation = latlng.LatLng(
    0,
    0,
  );
  @override
  Widget build(BuildContext context) {
    final latlng.LatLng _center = latlng.LatLng(
      widget.initialLocation.latitude,
      widget.initialLocation.longitude,
    );
    Marker _selectingMarker = Marker(
      width: 100,
      height: 100,
      point: _pickedLocation,
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 50,
      ),
    );
    Marker _locationMarker = Marker(
      width: 100,
      height: 100,
      point: _center,
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.blue,
        size: 50,
      ),
    );

    void _selectLocation(TapPosition tapPosition, latlng.LatLng position) {
      setState(() {
        _pickedLocation = position;
      });
    }

    MapOptions _options = MapOptions(
      center: _center,
      zoom: 14.0,
      onTap: widget.isSelecting == true ? _selectLocation : null,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: <Widget>[
          IconButton(
            onPressed: widget.isSelecting == true
                ? () {
                    Navigator.of(context).pop(_pickedLocation);
                  }
                : null,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: FlutterMap(
        options: _options,
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mellowdrag/ckvcm3cdy2a2j18rsta1a25ig/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWVsbG93ZHJhZyIsImEiOiJja3ZjZ3A1NHEwOHlpMnBxNWFnMnBwMHFqIn0.zxcyNLuholFyZJZjRMfX5w",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoibWVsbG93ZHJhZyIsImEiOiJja3ZjZ3A1NHEwOHlpMnBxNWFnMnBwMHFqIn0.zxcyNLuholFyZJZjRMfX5w',
              'id': 'mapbox.mapbox-streets-v8',
            },
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              widget.isSelecting == true ? _selectingMarker : _locationMarker,
              // ignore: unnecessary_null_comparison
            ],
          )
        ],
      ),
    );
  }
}
