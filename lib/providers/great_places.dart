// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tour_spotz/helpers/db_helpers.dart';
import 'package:tour_spotz/helpers/location_helper.dart';
import 'package:tour_spotz/models/place.dart';
// import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    String title,
    String description,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);

    final updatedLocation = PlaceLocation(
        address: address,
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude);
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: pickedImage,
      location: updatedLocation,
      title: title,
      description: description,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'description': newPlace.description,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> deletePlace(
    String id,
  ) async {
    DBHelper.delete('user_places', id);
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    print('abc');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            image: File(e['image']),
            location: PlaceLocation(
              address: e['address'],
              latitude: e['loc_lat'],
              longitude: e['loc_lng'],
            ),
            description: e['description'],
            title: e['title'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
