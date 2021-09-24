import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places_app/data/constants.dart';
import 'package:great_places_app/data/db_helper.dart';
import 'package:great_places_app/location/LocationHelper.dart';
import 'package:great_places_app/model/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  Future<void> addPlace(
    String userTitle,
    File userImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: userTitle,
      location: PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address,
      ),
      image: userImage,
    );

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(table_name, {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_lat": newPlace.location.latitude,
      "loc_lng": newPlace.location.longitude,
      "address": newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(table_name);
    _items = dataList
        .map((item) => Place(
              id: item["id"],
              title: item["title"],
              location: PlaceLocation(
                latitude: item["loc_lat"],
                longitude: item["loc_lng"],
                address: item["address"],
              ),
              image: File(item["image"]),
            ))
        .toList();
  }

  Future<void> deletePlace(String id) async {
    await DBHelper.delete(table_name, id);
    notifyListeners();
  }

  Place placeWithId(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
