import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pooly_car_main/core/enums/maps_state_enum.dart';
import 'package:pooly_car_main/product/services/destination_service.dart';
import 'package:pooly_car_main/product/services/find_place_service.dart';
import 'package:pooly_car_main/view/authentication/register/model/login_model.dart';

import '../../../product/models/destination_model.dart';

class MapViewModel extends GetxController {
  final Rx<MapState> _mapState = MapState.found.obs;
  final Rx<int> _activeCardIndex = 1.obs;

  final Rxn<Directions> _direction = Rxn<Directions>();
  final Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});
  final Rxn<LoginModel> _loginModel = Rxn<LoginModel>();
  final Rx<String> _estimatedFee = "".obs;

  void disposeCustom() {
    _markers.value = {};
    direction = null;
    activeCardIndex = 1;
    estimatedFee = "";
    loginModel=null;
  }

  void onInitCustom() {
    _markers.value = {};
    direction = null;
    activeCardIndex = 1;
    estimatedFee = "";
 
  }

  String get estimatedFee => _estimatedFee.value;
  set estimatedFee(String estimatedFee) {
    _estimatedFee.value = estimatedFee;
  }

  int get activeCardIndex => _activeCardIndex.value;
  set activeCardIndex(int index) {
    _activeCardIndex.value = index;
  }

  LoginModel? get loginModel => _loginModel.value;

  set loginModel(LoginModel? loginModel) {
    _loginModel.value = loginModel;
  }

  MapState get mapState => _mapState.value;

  set mapState(MapState mapState) {
    _mapState.value = mapState;
  }

  Directions? get direction => _direction.value;

  set direction(Directions? direction) {
    _direction.value = direction;
  }

  Set<Marker>? get markers => _markers.value;

  addMarker(Marker marker) {
    _markers.value.add(marker);
  }

  GoogleMapController? googleMapController;

  fetchTripByLoginModel(LoginModel loginModel) async {
    mapState = MapState.loading;
    this.loginModel = loginModel;
    Map departure =
        await FindPlaceService.instance.getPlace(loginModel.departurePlace);
    addMarker(Marker(
        markerId: const MarkerId("origin"),
        infoWindow: const InfoWindow(title: "origin"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
        position: LatLng(
            departure["location"]["lat"], departure["location"]["lng"])));
    Map destination =
        await FindPlaceService.instance.getPlace(loginModel.destination);
    addMarker(Marker(
        markerId: MarkerId('destination'),
        infoWindow: InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(
            destination["location"]["lat"], destination["location"]["lng"])));
    direction = await DirectionsService.instance.getDirections(
        origin:
            LatLng(departure["location"]["lat"], departure["location"]["lng"]),
        destination: LatLng(
            destination["location"]["lat"], destination["location"]["lng"]));
    print(direction!.bounds);
    //  print(directions);
    googleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(direction!.bounds, 110));
    estimatedFee = loginModel.estimatedFee;
    mapState = MapState.found;
  }

  fetchTripByText(String departureFromUser, String destinationFromUser) async {
    mapState = MapState.loading;
      Map departure  =
        await FindPlaceService.instance.getPlace(departureFromUser);
         addMarker(Marker(
        markerId: const MarkerId("origin"),
        infoWindow: const InfoWindow(title: "origin"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
        position: LatLng(
            departure["location"]["lat"], departure["location"]["lng"])));
             Map destination =
        await FindPlaceService.instance.getPlace( destinationFromUser);
     addMarker(Marker(
        markerId: MarkerId('destination'),
        infoWindow: InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(
            destination["location"]["lat"], destination["location"]["lng"])));
             direction = await DirectionsService.instance.getDirections(
        origin:
            LatLng(departure["location"]["lat"], departure["location"]["lng"]),
        destination: LatLng(
            destination["location"]["lat"], destination["location"]["lng"]));
            print(direction!.bounds);
              googleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(direction!.bounds, 110));
         estimatedFee = (double.parse(direction!.totalDistance.split(" ")[0])*1.5).toString();
    mapState = MapState.found;
  }
}
