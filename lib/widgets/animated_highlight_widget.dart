import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/hover_button.dart';

class AnimatedHighlightWidget extends ConsumerWidget {
  const AnimatedHighlightWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final keyword = Globals.highlightList[index];
    return DelayedDisplay(
      delay: Duration(milliseconds: 2500 + 100 + index * 200),
      child: HoverWidget(
        builder: (hovering) {
          final hoveredTransform = Matrix4.identity()
            ..translate(-48, 0, 0)
            ..scale(1.2);
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