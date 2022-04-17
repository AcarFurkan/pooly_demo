import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pooly_car_main/core/enums/maps_state_enum.dart';
import 'package:pooly_car_main/view/map/viewmodel/map_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition initialCameraPosition = CameraPosition(
      bearing: 0, target: LatLng(41.0054989, 28.7313176), tilt: 0, zoom: 9);

  final MapViewModel _mapViewModel = Get.put(MapViewModel());
  @override
  void dispose() {
    // TODO: implement dispose
    print("object");
    _mapViewModel.disposeCustom(); 
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mapViewModel.onInitCustom();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                onMapCreated: (controller) =>
                    _mapViewModel.googleMapController = controller,
                myLocationButtonEnabled: false,
                initialCameraPosition: initialCameraPosition,
                markers:
                    _mapViewModel.markers != null ? _mapViewModel.markers! : {},
                polylines: {
                  if (_mapViewModel.direction != null)
                    Polyline(
                        polylineId: PolylineId("overview_polyline"),
                        color: Colors.red,
                        width: 5,
                        points: _mapViewModel.direction!.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList())
                },
              )),
          Obx((() => _mapViewModel.mapState == MapState.loading
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Container())),
          Obx((() => _mapViewModel.loginModel != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: height / 5,
                            width: width * .9,
                            child: Column(
                              children: [
                                Text(
                                    "Kalkış noktası: " +
                                        _mapViewModel
                                            .loginModel!.departurePlace,
                                    style: TextStyle(color: Colors.black)),
                                Text(
                                    "Varış noktası: " +
                                        _mapViewModel.loginModel!.destination,
                                    style: TextStyle(color: Colors.black)),
                                Text(
                                    "Tahmini yolculuk süresi: " +
                                        _mapViewModel
                                            .loginModel!.estimatedTravelTime +
                                        " dakika",
                                    style: TextStyle(color: Colors.black)),
                                Text(
                                    "Tahmini ücret: " +
                                        (_mapViewModel.estimatedFee==""?_mapViewModel
                                            .loginModel!.estimatedFee:_mapViewModel.estimatedFee)+" ₺",
                                    style: TextStyle(color: Colors.black)),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: passangerGenerator
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                )
              : Container()))
        ],
      ),
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.black87, backgroundColor: Color(0xff5CA1FE),
    minimumSize: Size(88, 36),
    //padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );
  List<Widget> get passangerGenerator {
    List<Widget> list = [];
    for (var i = 1; i <= 4; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ElevatedButton(
            style: TextButton.styleFrom(
              primary: Colors.black87,
              backgroundColor: _mapViewModel.activeCardIndex == i
                  ? Color(0xff5CA1FE)
                  : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
            ),
            onPressed: () {
              _mapViewModel.activeCardIndex = i;
              _mapViewModel.estimatedFee=(double.parse(_mapViewModel.loginModel!.estimatedFee) / i)
                        .toStringAsFixed(1);
            },
            child: Column(
              children: [
                Text("$i yolcu"),
                Text((double.parse(_mapViewModel.loginModel!.estimatedFee) / i)
                        .toStringAsFixed(1) +
                    " ₺")
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }
}
