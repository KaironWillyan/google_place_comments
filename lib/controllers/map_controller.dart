import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/place_model.dart';

class MapController {
  static const String apiKey = 'AIzaSyBZ9xKZG-NVCbpgtn4YqkaEtzezR4_VaVg';

  Future<List<Place>> getNearbyPlaces(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1500&type=restaurant&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> placesJson = data['results'];
      return placesJson.map((json) => Place.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load nearby places');
    }
  }
}
