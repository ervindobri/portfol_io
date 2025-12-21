import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:animated_gradient_border/animated_gradient_border.dart';

class AppPrimaryButton extends HookWidget {
  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isPressed = useState(false);
    return AnimatedScale(
      scale: isPressed.value ? 0.95 : 1,
      duration: const Duration(milliseconds: 150),
      child: GestureDetector(
        onTapDown: (_) => isPressed.value = true,
        onTapUp: (_) => isPressed.value = false,
        onTapCancel: () => isPressed.value = false,
        behavior: HitTestBehavior.translucent,
        child: AnimatedGradientBorder(
          colors: [
            Colors.transparent,
            Colors.white,
            context.theme.primaryColor,
            Colors.white,
            Colors.transparent,
          ],
          glowSigma: 1.4,
          borderWidth: 4,
          borderRadius: 256,
          child: TextButton(
            style: GlobalStyles.primaryButtonStyle(theme).copyWith(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(256),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Row(
                spacing: 24,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.textColor),
                  ),
                  SvgPicture.asset(
                    icon,
                    height: 32,
                    width: 32,
                    colorFilter: ColorFilter.mode(
                      theme.textColor,
                      BlendMode.srcIn,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
