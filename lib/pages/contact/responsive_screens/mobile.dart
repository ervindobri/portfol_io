import 'package:flutter/material.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/contact/contact_me_card.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';
import 'package:portfol_io/pages/contact/widgets/contact_profile_image.dart';
import 'package:portfol_io/widgets/delayed_display.dart';

class ContactMobile extends StatefulWidget {
  const ContactMobile({super.key});

  @override
  State<ContactMobile> createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 32,
        children: [
          SizedBox(height: kToolbarHeight + 12),
          MobileContactProfileImage(),
          MobileContactInfo(),
          DelayedDisplay(
            slidingBeginOffset: Offset(0, 0),
            child: MobileContactMeCard(),
          ),
        ],
      ),
    );
  }
}
