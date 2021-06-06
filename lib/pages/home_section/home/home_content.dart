import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfol_io/controller/home_controller.dart';
import 'package:portfol_io/pages/home_section/home/responsive_screens/home_desktop.dart';
import 'package:portfol_io/pages/home_section/home/responsive_screens/home_tablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeContent extends StatefulWidget {
  final VoidCallback onPressedCheckMe;

  const HomeContent({Key? key, required this.onPressedCheckMe})
      : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController())!;
  var random = new Random();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: homeController,
      builder: (controller) {
        return ScreenTypeLayout(
            breakpoints:
                ScreenBreakpoints(tablet: 666, desktop: 1000, watch: 300),
            mobile: HomeDesktop(onPressedCheckMe: widget.onPressedCheckMe),
            tablet: HomeTablet(onPressedCheckMe: widget.onPressedCheckMe),
            desktop: HomeDesktop(onPressedCheckMe: widget.onPressedCheckMe));
      },
    );
  }
}
