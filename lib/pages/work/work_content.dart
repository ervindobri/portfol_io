import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/pages/work/responsive_screens/work.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WorkContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return WorkDesktop();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return WorkDesktop();
        }
        return OrientationLayoutBuilder(
          portrait: (context) => WorkMobile.portrait(),
          landscape: (context) => WorkMobile.landscape(),
        );
      },
    );
  }
}
