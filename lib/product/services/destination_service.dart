import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/destination_model.dart';
 
class DirectionsService {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";
  late final Dio _dio;
  static DirectionsService? _instance;

  static DirectionsService get instance {
    _instance ??= DirectionsService._init();
    return _instance!;
  }

  DirectionsService._init() {
    _dio = Dio();
  }

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI'
      });
      switch (response.statusCode) {
        case 200:
          return Directions.fromMap(response.data);
        case 400:
          break;
        default:
      }
      if (response.statusCode == 200) {
        return Directions.fromMap(response.data);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
  //https://maps.googleapis.com/maps/api/directions/json?&origin=39.9333635%2C32.8597419&destination=41.0082376%2C28.9783589&key=AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI

//https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJsS1zINVH0xQRjSuEwLBX3As&key=AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI 
 //https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI&placeid=ChIJS22qaQYFJzYRluDmNzkh3eA
//https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=mongolian&inputtype=textquery&key=AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI

//https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=mongolian&inputtype=textquery&locationbias=circle%3A2000%4047.6918452%2C-122.2226413&key=AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI