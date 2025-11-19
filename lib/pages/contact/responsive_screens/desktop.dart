import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
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
    final theme = ref.watch(themeProvider);

    return ClipRRect(
      child: Container(
        constraints: const BoxConstraints(maxWidth: Globals.maxBoxWidth),
        margin: const EdgeInsets.all(24).copyWith(
          top: kToolbarHeight * 2,
        ),
        width: width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(64),
            topRight: Radius.circular(128),
          ),
          color: ref.watch(themeColorProvider),
        ),
        alignment: Alignment.center,
        child: Column(
          spacing: 24,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  SelectableText(
                    Globals.contactTitle,
                    style: theme.inverseBodyLarge,
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: ContactProfileImage(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24),
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
            const AnimatedSwitcher(
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
    );
  }
}
