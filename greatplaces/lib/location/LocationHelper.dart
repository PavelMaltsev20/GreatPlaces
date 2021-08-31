import 'dart:convert';

import 'package:great_places_app/data/constants.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    final selectedPlace = "$latitude,$longitude";
    return "https://maps.googleapis.com/maps/api/staticmap"
        "?center=$selectedPlace"
        "&zoom=13&size=600x300"
        "&maptype=roadmap"
        "&markers=color:red%7Clabel:Here%7C$selectedPlace"
        "&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final params = {
      "latlng": "$lat,$lng",
      "key": GOOGLE_API_KEY,
    };
    final url = "maps.googleapis.com";
    final selectedPlace = "/maps/api/geocode/json";

    final urlRequest = Uri.https(url, selectedPlace, params);
    final response = await http.get(urlRequest);

    return json.decode(response.body)["results"][0]["formatted_address"];
  }
}
