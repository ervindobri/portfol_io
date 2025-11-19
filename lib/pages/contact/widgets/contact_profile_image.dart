import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'package:portfol_io/constants/images.dart';

class ContactProfileImage extends StatelessWidget {
  const ContactProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        // const Center(
        //   child: DelayedDisplay(
        //     delay: Duration(milliseconds: 10),
        //     fadingDuration: Duration(milliseconds: 100),
        //     child: SocialMediaSection(),
        //   ),
        // ),
        ],
    );
  }
}
