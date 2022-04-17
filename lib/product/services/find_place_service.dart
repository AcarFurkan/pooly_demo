import 'package:dio/dio.dart';

class FindPlaceService {
  static FindPlaceService? _instance;
  static const String _baseUrl = "https://maps.googleapis.com/maps/api/place/";

  static const String _apiKey = "AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI";
  
  static FindPlaceService get instance {
    _instance ??= FindPlaceService._init();
    return _instance!;
  }

  late final Dio _dio;

  FindPlaceService._init() {
    _dio = Dio();
  }
  Future<String> getPlaceId(String placeName) async {
    try {
      final response = await _dio
          .get(_baseUrl + "findplacefromtext/json?", queryParameters: {
        "key": _apiKey,
        "input": placeName,
        "inputtype": "textquery",
      });
      switch (response.statusCode) {
        case 200:
          // response.data[]
          return response.data["candidates"][0]["place_id"].toString();
        default:
          return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<Map> getPlace(String placeName) async {
    String placeId = await getPlaceId(placeName);
    try {
      final response = await _dio.get(_baseUrl + "details/json?",
          queryParameters: {"key": _apiKey, "placeid": placeId});
      switch (response.statusCode) {
        case 200:
          // response.data[]
          return response.data["result"]["geometry"] ;
        default:
          return Map();
      }
    } catch (e) {
      print(e);
      return Map();
    }
  }
}
//https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI&input=ankara&inputtype=textquery
  //https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJsS1zINVH0xQRjSuEwLBX3As&key=AIzaSyCqGXtAMdKQN5U-OP7DkDC2tEoCGham5mI