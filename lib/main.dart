import 'package:flutter/material.dart';
import 'package:pooly_car_main/view/authentication/select_customer_type/select_customer_type_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff1b6cde))),
        ),
        
      ),
      home: const SelectCustomerTypePage(),
    );
  }
}
 //// ThemeData(
   //   
   //     appBarTheme: AppBarTheme(backgroundColor:Color(0xff5CA0FF) ),
   //     elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff5CA0FF))),),
   //     primaryColor: Color(0xff5CA0FF)
   //   ),