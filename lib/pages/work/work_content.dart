import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/pages/work/responsive_screens/work.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WorkContent extends StatelessWidget {
  const WorkContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return const WorkDesktop();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return const WorkDesktop();
        }
        return OrientationLayoutBuilder(
          portrait: (context) => WorkMobile.portrait(),
          landscape: (context) => WorkMobile.landscape(),
        );
      },
    );
  }
}
