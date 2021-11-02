import 'dart:convert';

import 'package:http/http.dart' as http;

const MAPBOX_API_KEY =
    'pk.eyJ1IjoibWVsbG93ZHJhZyIsImEiOiJja3ZjZ3Vtdmw0a2YyMm5xd2pxbXlhNTBrIn0.Fj2fvaa6ig02ZaEdrJ1xkQ';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l+000($longitude,$latitude)/$longitude,$latitude,16/600x600?access_token=$MAPBOX_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$MAPBOX_API_KEY');
    final response = await http.get(url);
    String addressMessage;

    try {
      addressMessage =
          (json.decode(response.body)['features'][0]['properties']['address']);
    } catch (e) {
      addressMessage = 'Address not found, only coordinates saved.';
    }

    return addressMessage;
  }
}
