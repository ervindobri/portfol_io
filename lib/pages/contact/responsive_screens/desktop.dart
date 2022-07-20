import 'package:flutter/material.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/contact/contact_me_card.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';

class ContactDesktop extends StatefulWidget {
  ContactDesktop({Key? key}) : super(key: key);

  @override
  State<ContactDesktop> createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactDesktop> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: Container(
        height: height,
        width: width,
        color: Color(0xff292929),
        alignment: Alignment.center,
        child: Wrap(
          spacing: width / 10,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            ParallaxCard(),
            ContactMeCard(),
          ],
        ),
      ),
    );
  }
}
