import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'package:portfol_io/constants/images.dart';
import 'package:portfol_io/pages/contact/social_media_section.dart';
import 'package:portfol_io/widgets/delayed_display.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';

class ContactProfileImage extends StatelessWidget {
  const ContactProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HoverWidget(builder: (context, hovering) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Motion(
            controller: MotionController(maxAngle: 0.1, damping: 0.05),
            borderRadius: BorderRadius.circular(24),
            glare: const GlareConfiguration(
              maxOpacity: 0,
              minOpacity: 0,
              color: Colors.transparent,
            ),
            shadow: const ShadowConfiguration(
              opacity: 0,
              color: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                AppImages.profileBg,
                height: 430,
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: hovering ? 1.0 : 0.0,
            duration: kThemeAnimationDuration,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(.3)),
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: ProAnimatedBlur(
                    blur: hovering ? 32 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    child: const DelayedDisplay(
                      delay: Duration(milliseconds: 10),
                      fadingDuration: Duration(milliseconds: 100),
                      child: SocialMediaSection(),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
