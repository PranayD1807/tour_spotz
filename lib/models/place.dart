import 'dart:io';

// import 'package:flutter/foundation.dart';
class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  const PlaceLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
  final String description;

  Place({
    required this.id,
    required this.image,
    required this.location,
    required this.title,
    required this.description,
  });
}
