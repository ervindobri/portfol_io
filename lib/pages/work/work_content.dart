import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/pages/work/responsive_screens/work.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WorkContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        breakpoints: ScreenBreakpoints(tablet: 666, desktop: 1000, watch: 300),
        mobile: WorkDesktop(),
        tablet: WorkTablet(),
        desktop: WorkDesktop());
  }
}
