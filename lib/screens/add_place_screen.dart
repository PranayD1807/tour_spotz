import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tour_spotz/models/place.dart';
// import 'package:location/location.dart';
import 'package:tour_spotz/providers/great_places.dart';
import 'package:tour_spotz/widgets/image_input.dart';
import 'package:provider/provider.dart';
import 'package:tour_spotz/widgets/location_input.dart';
// import '../providers//great_places.dart';

// import '';
class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  PlaceLocation _pickedLocation =
      const PlaceLocation(address: 'unselected', latitude: 0.0, longitude: 0.0);
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation =
        PlaceLocation(address: 'unselected', latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation ==
            const PlaceLocation(address: '', latitude: 0.0, longitude: 0.0)) {
      return;
    }
    try {
      Provider.of<GreatPlaces>(context, listen: false).addPlace(
        _titleController.text,
        _descriptionController.text,
        _pickedImage!,
        _pickedLocation,
      );
    } catch (error) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Spot'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      maxLength: 200,
                      // maxLines: ,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      controller: _descriptionController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text(
              'Add Place',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: _savePlace,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
