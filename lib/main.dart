import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/pages/main_page.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // var homeController = Get.put(HomeController())!;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PortfolIO',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: ThemeUtils.primaryColor,
        accentColor: ThemeUtils.primaryColor,
        // Define the default font family.
        fontFamily: 'Poppins',
        textTheme: GoogleFonts.poppinsTextTheme(TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        )),
      ),
      home: HomePage(),
      // home: ResponsiveWrapper.builder(,
      //     maxWidth: Get.width,
      //     minWidth: 480,
      //     defaultScale: true,
      //     breakpoints: [
      //       ResponsiveBreakpoint.resize(480, name: MOBILE),
      //       ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //       ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      //     ],
      //     background: Container(color: Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
    );
  }
}
