import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/pages/home_section/home/responsive_screens/home_desktop.dart';
import 'package:portfol_io/pages/home_section/home/responsive_screens/home_tablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        breakpoints: ScreenBreakpoints(tablet: 666, desktop: 1000, watch: 300),
        mobile: HomeDesktop(),
        tablet: HomeTablet(),
        desktop: HomeDesktop());
  }
}
