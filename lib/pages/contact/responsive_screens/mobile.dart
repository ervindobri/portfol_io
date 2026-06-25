import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/pages/contact/contact_me_card.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';
import 'package:portfol_io/pages/contact/widgets/contact_profile_image.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactMobile extends HookWidget {
  const ContactMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final animateImage = useState(false);
    final animateInfo = useState(false);
    final animateActions = useState(false);

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 32,
        children: [
          SizedBox(height: context.topPadding + kToolbarHeight),
          VisibilityDetector(
            key: const ValueKey('contact_image_mobile'),
            onVisibilityChanged: (visible) {
              animateImage.value = visible.visibleFraction > 0.15;
            },
            child: FadeInDown(
              animate: animateImage.value,
              delay: const Duration(milliseconds: 200),
              child: const AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: MobileContactProfileImage(),
              ),
            ),
          ),
          VisibilityDetector(
            key: const ValueKey('contact_info_mobile'),
            onVisibilityChanged: (visible) {
              animateInfo.value = visible.visibleFraction > 0.15;
            },
            child: FadeInUp(
              animate: animateInfo.value,
              delay: const Duration(milliseconds: 400),
              child: const AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: MobileContactInfo(),
              ),
            ),
          ),
          VisibilityDetector(
            key: const ValueKey('contact_actions_mobile'),
            onVisibilityChanged: (visible) {
              animateActions.value = visible.visibleFraction > 0.15;
            },
            child: ZoomIn(
              animate: animateActions.value,
              delay: const Duration(milliseconds: 600),
              child: const MobileContactMeCard(),
            ),
          ),
        ],
      ),
    );
  }
}
