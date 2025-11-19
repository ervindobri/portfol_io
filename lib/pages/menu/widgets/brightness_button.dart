import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/providers/providers.dart';

class BrightnessButton extends ConsumerWidget {
  const BrightnessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final isDarkMode = theme.brightness == Brightness.dark;

    return  InkWell(
      onTap: () => ref.read(themeProvider.notifier).switchBrightness(),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: theme.inverseTextColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: Image.asset(
            isDarkMode ? AppIcons.bulbLight : AppIcons.bulbDark,
            color: theme.textColor,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}