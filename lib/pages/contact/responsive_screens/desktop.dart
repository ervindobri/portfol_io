import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/contact/contact_me_card.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';
import 'package:portfol_io/pages/contact/widgets/contact_profile_image.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/delayed_display.dart';

class ContactDesktop extends ConsumerStatefulWidget {
  const ContactDesktop({super.key});

  @override
  ConsumerState<ContactDesktop> createState() => _ContactDesktopState();
}

class _ContactDesktopState extends ConsumerState<ContactDesktop> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final width = context.width;

    return ClipRRect(
      child: Container(
        constraints: BoxConstraints(
          minHeight: context.height - kToolbarHeight * 4,
          maxWidth: Globals.maxBoxWidth,
        ),
        width: width,
        margin: const EdgeInsets.only(
            top: kToolbarHeight * 2, bottom: kToolbarHeight * 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(64),
              topRight: Radius.circular(128),
            ),
            color: ref.watch(themeColorProvider),
          ),
          child: const Column(
            spacing: 48,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 48,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedSwitcher(
                          duration: kThemeAnimationDuration,
                          child: DelayedDisplay(
                            delay: Duration(milliseconds: 100),
                            fadingDuration: Duration(milliseconds: 100),
                            child: MobileContactProfileImage(
                              height: 400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        AnimatedSwitcher(
                          duration: kThemeAnimationDuration,
                          child: DelayedDisplay(
                            delay: Duration(milliseconds: 100),
                            fadingDuration: Duration(milliseconds: 100),
                            child: ContactInfo(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  fadingDuration: Duration(milliseconds: 100),
                  child: ContactMeCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
