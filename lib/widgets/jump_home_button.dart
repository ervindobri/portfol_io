import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/animated_icon_button.dart';
import 'package:portfol_io/widgets/delayed_display.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:responsive_builder/responsive_builder.dart';

class JumpToHomeButton extends ConsumerWidget {
  const JumpToHomeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiMenuManager = sl<UiMenuManager>();
    final menuIndex = ref.watch(menuIndexProvider);
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      final isMobile =
          sizingInformation.deviceScreenType == DeviceScreenType.mobile;
      if (!isMobile) {
        return AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: menuIndex < 1
              ? const SizedBox()
              : DelayedDisplay(
                  slidingBeginOffset: const Offset(0, 2),
                  fadingDuration: kThemeAnimationDuration,
                  child: AnimatedIconButton(
                    onPressed: () {
                      uiMenuManager.setPage(0);
                      ref.read(menuIndexProvider.notifier).state = 0;
                    },
                    icon: const Icon(
                      FontAwesomeIcons.chevronUp,
                      color: Colors.white,
                    ),
                  ),
                ),
        );
      }
      return AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: menuIndex < 1
            ? const SizedBox()
            : FadingSlideWidget(
                offset: const Offset(0, 2),
                durationMilliseconds: 300,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: AnimatedIconButton(
                    onPressed: () {
                      uiMenuManager.setPage(0);
                      ref.read(menuIndexProvider.notifier).state = 0;
                    },
                    icon: const Icon(
                      FontAwesomeIcons.chevronUp,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
