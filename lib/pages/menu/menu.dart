import 'package:flutter/material.dart';
import 'package:portfol_io/pages/menu/menu_desktop.dart';
import 'package:portfol_io/pages/menu/menu_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StickyMenu extends StatelessWidget {
  const StickyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return const MenuDesktop();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return const MenuDesktop();
        }
        return MenuMobile();
      },
    );
  }
}
