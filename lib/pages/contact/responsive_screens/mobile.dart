import 'package:flutter/material.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/contact/contact_me_card.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';

class ContactMobile extends StatefulWidget {
  ContactMobile({Key? key}) : super(key: key);

  @override
  State<ContactMobile> createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: Container(
        height: height + 32 + 32,
        width: width,
        color: Color(0xff292929),
        child: Wrap(
          spacing: 24,
          runSpacing: 24,
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(height: 36),
            MobileParallaxCard(),
            MobileContactMeCard(),
          ],
        ),
      ),
    );
  }
}
