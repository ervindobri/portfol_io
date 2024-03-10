import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/contact/contact_me_card.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';

class ContactDesktop extends StatefulWidget {
  const ContactDesktop({super.key});

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
        alignment: Alignment.center,
        child: ValueListenableBuilder(
          valueListenable: uiMenuManager.playContactAnimation,
          builder: (context, bool value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: width / 10,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: !value
                          ? const SizedBox()
                          : const DelayedDisplay(
                              delay: Duration(milliseconds: 100),
                              fadingDuration: Duration(milliseconds: 100),
                              child: ParallaxCard(),
                            ),
                    ),
                    AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: !value
                          ? const SizedBox()
                          : const DelayedDisplay(
                              delay: Duration(milliseconds: 100),
                              fadingDuration: Duration(milliseconds: 100),
                              child: ContactMeCard(),
                            ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    "*Note: this section is currently under development",
                    style: context.bodyText2,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
