import 'package:flutter/material.dart';
import 'package:portfol_io/constants/theme.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/main_page.dart';

void main() {
  Paint.enableDithering = true;
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // var homeController = Get.put(HomeController())!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PortfolIO',
      theme: PortfolioTheme.theme,
      home: HomePage(),
      // home: ResponsiveWrapper.builder(,
      //     maxWidth: width,
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
