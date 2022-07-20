import 'package:flutter/material.dart';
import 'package:portfol_io/pages/menu/menu_desktop.dart';
import 'package:portfol_io/pages/menu/menu_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StickyMenu extends StatelessWidget {
  const StickyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(tablet: 666, desktop: 1000, watch: 300),
      mobile: MenuMobile(),
      tablet: MenuDesktop(),
      desktop: MenuDesktop(),
    );
  }
}
