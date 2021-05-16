import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/pages/home_section/controller/home_controller.dart';
import 'package:portfol_io/pages/main_page.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // var homeController = Get.put(HomeController())!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: ThemeUtils.primaryColor,
        accentColor: ThemeUtils.primaryColor,
        // Define the default font family.
        fontFamily: 'Oswald',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: HomePage(),
    );
  }
}