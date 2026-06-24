import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/pages/contact/contact_me_card.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';
import 'package:portfol_io/pages/contact/widgets/contact_profile_image.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactDesktop extends HookWidget {
  const ContactDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final animateImage = useState(false);
    final animateInfo = useState(false);
    final animateActions = useState(false);

    return ClipRRect(
      child: Container(
        constraints: BoxConstraints(
          minHeight: context.height - kToolbarHeight * 4,
          maxWidth: Globals.maxBoxWidth,
        ),
        width: width,
        margin: const EdgeInsets.only(
          top: kToolbarHeight * 2,
          bottom: kToolbarHeight * 2,
        ),
        child: Column(
          spacing: 128,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 96,
              children: [
                Expanded(
                  child: VisibilityDetector(
                    key: const ValueKey('contact_image'),
                    onVisibilityChanged: (visible) {
                      animateImage.value = visible.visibleFraction > 0.15;
                    },
                    child: FadeInLeft(
                      animate: animateImage.value,
                      delay: const Duration(milliseconds: 200),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedSwitcher(
                            duration: kThemeAnimationDuration,
                            child: MobileContactProfileImage(
                              height: 500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: VisibilityDetector(
                    key: const ValueKey('contact_info'),
                    onVisibilityChanged: (visible) {
                      animateInfo.value = visible.visibleFraction > 0.21;
                    },
                    child: FadeInRight(
                      animate: animateInfo.value,
                      delay: const Duration(milliseconds: 500),
                      child: const AnimatedSwitcher(
                        duration: kThemeAnimationDuration,
                        child: ContactInfo(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            VisibilityDetector(
              key: const ValueKey('contact_actions'),
              onVisibilityChanged: (visible) {
                animateActions.value = visible.visibleFraction > 0.21;
              },
              child: ZoomIn(
                animate: animateActions.value,
                delay: const Duration(milliseconds: 700),
                child: const ContactMeCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
