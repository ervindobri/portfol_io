import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/hover_button.dart';

class AnimatedIconButton extends ConsumerWidget {
  AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final VoidCallback onPressed;

  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);
    return MouseRegion(
      child: HoverWidget(
        builder: (hovering) => InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: AnimatedContainer(
            decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(hovering ? 12 : 8),
                boxShadow: [
                  BoxShadow(
                    color: themeColor.withOpacity(
                      hovering ? .24 : .12,
                    ),
                    offset: const Offset(0, 24),
                    blurRadius: 24,
                    spreadRadius: -2,
                  ),
                ]),
            padding: const EdgeInsets.all(24.0),
            duration: kThemeAnimationDuration,
            child: icon,
          ),
        ),
      ),
    );
  }
}
