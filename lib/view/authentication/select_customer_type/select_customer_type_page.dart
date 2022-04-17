import 'package:flutter/material.dart';
import 'package:pooly_car_main/core/constants/app_constant.dart';
import 'package:pooly_car_main/view/authentication/register/view/register_page.dart';

class SelectCustomerTypePage extends StatelessWidget {
  const SelectCustomerTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        title: Text("Müşteri Tipini Seçiniz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppConstants.instance.APP_LOGO_TRANSPARENT),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text("Yolcu")),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Sürücü"))
          ],
        ),
      ),
    );
  }
}
