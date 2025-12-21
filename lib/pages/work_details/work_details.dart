import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/responsive_screens/work.dart';
import 'package:portfol_io/pages/work_details/desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WorkDetailsScreen extends StatelessWidget {
  const WorkDetailsScreen({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return WorkDetailsDesktop(item: item);
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return WorkDetailsDesktop(item: item);
        }
        return OrientationLayoutBuilder(
          portrait: (context) => WorkMobile.portrait(item: item),
          landscape: (context) => WorkMobile.landscape(item: item),
        );
      },
    );
  }
}
