import 'dart:convert';
import 'package:http/http.dart' as http;

class PlacesService {
  static final String apiKey = 'AIzaSyAZ0zmiKFd382iqbdxu0O8J_r9Fk0y0P_I'; // Replace with your actual API key

  Future<List<String>> getTouristPlaces(double latitude, double longitude, double radius, String countryCode) async {
    final uri = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json')
        .replace(queryParameters: {
      'location': '$latitude,$longitude',
      'radius': '$radius',
      'type': 'tourist_attraction',
      'country': countryCode, // Add the country code parameter
      'key': apiKey,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;

      List<String> places = [];
      for (var result in results) {
        places.add(result['name']);
      }
      return places;
    } else {
      throw Exception('Failed to load tourist places');
    }
  }
}
