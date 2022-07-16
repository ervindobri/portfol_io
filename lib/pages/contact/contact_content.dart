import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/pages/contact/responsive_screens/contact.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContactContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        breakpoints: ScreenBreakpoints(tablet: 666, desktop: 1000, watch: 300),
        mobile: ContactDesktop(),
        tablet: ContactTablet(),
        desktop: ContactDesktop());
  }
}
