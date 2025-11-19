import 'package:flutter/material.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';

class ContactMobile extends StatefulWidget {
  const ContactMobile({super.key});

  @override
  State<ContactMobile> createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Text(
          "WIP",
          style: context.bodyText1,
        ),
      ),
    );
  }
}
