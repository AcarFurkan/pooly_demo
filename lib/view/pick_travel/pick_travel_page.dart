import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pooly_car_main/view/authentication/register/model/login_model.dart';

import '../map/view/map_page.dart';
import '../map/viewmodel/map_controller.dart';

class PickTravelPage extends StatelessWidget {
  PickTravelPage({Key? key, required this.customerName}) : super(key: key);
  final String customerName;
  LoginModel? loginModel;
  final MapViewModel _mapViewModel = Get.put(MapViewModel());
  TextEditingController departureController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yolculuk Sayfası"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  controller: departureController,
                  decoration: const InputDecoration(
                      labelText: "Kalkış yeri",
                      hintText: "Kalkış yeri",
                      border: OutlineInputBorder()))),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  controller: destinationController,
                  decoration: const InputDecoration(
                      labelText: "Varış Yeri",
                      hintText: "Varış Yeri",
                      border: OutlineInputBorder()))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    //  TimePickerDialog(initialTime: TimeOfDay.now());
                  },
                  child: const Text("Kalkış Saati Seç"))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    List<LoginModel> models = LoginModel.mockUsers;
                    models.forEach((element) {
                      if (element.name == customerName) {
                        loginModel = element;
                      }
                    });
                    loginModel != null
                        ? _mapViewModel.fetchTripByLoginModel(loginModel!)
                        : _mapViewModel.fetchTripByText(
                            departureController.text.trim(),
                            destinationController.text.trim());
                            /**
                             * 
                             _mapViewModel.fetchTripByText(
                            departureController.text.trim(),
                            destinationController.text.trim())
                             */
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapPage()));
                  },
                  child: const Text("Yolculuk Ara"))),
        ],
      )),
    );
  }
}
