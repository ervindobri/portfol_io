import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/pages/home/responsive_screens/home.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  HomeContentState createState() => HomeContentState();
}

class HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return const HomeDesktop();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return const HomeTablet();
        }
        return OrientationLayoutBuilder(
          portrait: (context) => HomeMobile.portrait(),
          landscape: (context) => HomeMobile.landscape(),
        );
      },
    );
  }
}
