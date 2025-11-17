import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/hover_button.dart';

class AnimatedIconButton extends ConsumerWidget {
  AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isMobile = false,
  });

  final Widget icon;
  final bool isMobile;
  final VoidCallback onPressed;

  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);
    return MouseRegion(
      child: HoverWidget(
        builder: (context, hovering) => InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: AnimatedContainer(
            decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(hovering ? 12 : 8),
                boxShadow: [
                  BoxShadow(
                    color: context.theme.extBackgroundColor.withAlpha(
                      hovering ? 64 : 32,
                    ),
                    offset: const Offset(0, 24),
                    blurRadius: 24,
                    spreadRadius: -2,
                  ),
                ]),
            padding: isMobile
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.all(24.0),
            duration: kThemeAnimationDuration,
            child: icon,
          ),
        ),
      ),
    );
  }
}
