import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pooly_car_main/core/constants/app_constant.dart';
import 'package:pooly_car_main/view/authentication/register/model/login_model.dart';
import 'package:pooly_car_main/view/pick_travel/pick_travel_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final TextEditingController _nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Sayfası"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              child: Stack(children: [
                image != null
                    ? Image.file(image!)
                    : Image.asset(AppConstants.instance.PROFILE_AVATAR,fit: BoxFit.scaleDown,),
                 
              ]),
            ),
            ElevatedButton(
                onPressed: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image == null) {
                    return;
                  }
                  final imageTemporary = File(image.path);
                  setState(() {
                    this.image = imageTemporary;
                  });
                },
                child: Text("Pick image")),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: "Isim",
                        hintText: "Isim",
                        border: OutlineInputBorder()))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Soyisim",
                        hintText: "Soyisim",
                        border: OutlineInputBorder()))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Yaş",
                        hintText: "Yaş",
                        border: OutlineInputBorder()))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Üniversite adı ve bölümü",
                        hintText: "Üniversite adı ve bölümü",
                        border: OutlineInputBorder()))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Üniversite mail adresi",
                        hintText: "Üniversite mail adresi",
                        border: OutlineInputBorder()))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      List<LoginModel> models = LoginModel.mockUsers;

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => PickTravelPage(
                              customerName: _nameController.text.trim()))));
                    },
                    child: const Text("Kaydı Tamamla"))),
          ],
        ),
      )),
    );
  }
}
