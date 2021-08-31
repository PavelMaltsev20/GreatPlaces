import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:great_places_app/model/place.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/widget/image_input.dart';
import 'package:great_places_app/widget/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place-screen";

  const AddPlaceScreen({Key key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlacesProvider>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      _pickedLocation,
    );
    Navigator.of(context).pop();
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add new place"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                        controller: _titleController,
                      ),
                      SizedBox(height: 10),
                      ImageInput(_selectImage),
                      SizedBox(height: 10),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("add place"),
                  onPressed: _savePlace),
            ),
          ],
        ));
  }
}
