import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion/motion.dart';
import 'package:portfol_io/constants/images.dart';
import 'package:portfol_io/extensions/build_context.dart';

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

class MobileContactProfileImage extends StatefulWidget {
  const MobileContactProfileImage({
    super.key,
    this.height,
  });

  final double? height;

  @override
  State<MobileContactProfileImage> createState() =>
      _MobileContactProfileImageState();
}

class _MobileContactProfileImageState extends State<MobileContactProfileImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isFront = true;
  bool _isFlipping = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    _controller.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      // After completing flip to back, wait then flip back to front.
      if (!_isFront) {
        HapticFeedback.lightImpact();
        await Future.delayed(const Duration(milliseconds: 300));
        _controller.reverse();
        HapticFeedback.lightImpact();
      }
      setState(() {
        _isFlipping = false;
        if (!_isFront) _isFront = true; // After reverse, show front again
      });
    } else if (status == AnimationStatus.dismissed) {
      setState(() {
        _isFront = true; // Now showing front after reverse
        _isFlipping = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (!_isFlipping && _isFront) {
      setState(() {
        _isFront = false;
        _isFlipping = true;
      });
      _controller.forward(from: 0);
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Flip on Y axis
          double angle = _animation.value * 3.141592653589793;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                AppImages.profileBg,
                height: widget.height ?? context.height / 3,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
