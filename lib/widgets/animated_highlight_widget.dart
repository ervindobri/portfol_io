import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/delayed_display.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hooks;

class AnimatedHighlightWidget extends ConsumerWidget {
  const AnimatedHighlightWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final keyword = Globals.highlightList[index];
    return DelayedDisplay(
      delay: Duration(milliseconds: 2500 + 100 + index * 200),
      child: HoverWidget(
        builder: (context, hovering) {
          final hoveredTransform = Matrix4.identity()
            ..translateByVector3(Vector3(-64, -8, 0))
            ..scaleByVector3(Vector3(1.35, 1.35, 1.35));
          final transform = hovering ? hoveredTransform : Matrix4.identity();
          return AnimatedContainer(
            duration: kThemeAnimationDuration,
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: theme.extBackgroundColor,
            ),
            transform: transform,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              keyword.toUpperCase(),
              style: theme.inverseBodyLarge,
            ),
          );
        },
      ),
    );
  }
}


class AnimatedHighlightMobileWidget extends hooks.HookConsumerWidget {
  const AnimatedHighlightMobileWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final keyword = Globals.highlightList[index];
    final pressed = useState(false);
    final pressedTransform = Matrix4.identity()
      ..translateByVector3(Vector3(-64, -8, 0))
      ..scaleByVector3(Vector3(1.35, 1.35, 1.35));
    final transform = pressed.value ? pressedTransform : Matrix4.identity();
    return DelayedDisplay(
      delay: Duration(milliseconds: 2500 + 100 + index * 200),
      child: GestureDetector(
        onTapDown: (details) {
          pressed.value = true;
        },
        onTapUp: (details) {
          pressed.value = false;
        },
        onTapCancel: () {
          pressed.value = false;
        },
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          curve: Curves.bounceInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: theme.extBackgroundColor,
          ),
          transform: transform,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            keyword.toUpperCase(),
            style: theme.inverseBodyLarge,
          ),
        ),
      ),
    );
  }
}
