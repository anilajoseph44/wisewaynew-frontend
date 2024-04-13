import 'dart:convert';
import 'package:google_maps_yt/models/placemodel.dart';
import 'package:http/http.dart' as http;


class PlaceService {
  static const String baseUrl = 'http://192.168.145.62:3002/api/places/';

  static Future<List<PlaceList>>fetchPlaces() async {
    final response = await http.get(Uri.parse('$baseUrl/viewplaces'));
    if (response.statusCode == 200) {
      print("successsssssssssssssss");
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PlaceList.fromJson(json)).toList();
    } else {
      throw Exception('okFailed to load places');
    }
  }
}
