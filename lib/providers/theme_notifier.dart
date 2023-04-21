import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme.dart';
import 'package:portfol_io/providers/providers.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier(this.ref) : super(PortfolioTheme.defaultDarkTheme);

  // State
  Brightness _brightness = Brightness.dark;
  Color _themeColor = GlobalColors.defaultThemeColor;

  Color get themeColor => state.primaryColor;

  final Ref ref;

  void changeThemeColor(Color value) {
    ref
        .read(previousThemeColorProvider.notifier)
        .update((_) => state.primaryColor);
    state = state.copyWith(primaryColor: value);
    print(state.primaryColor);
  }

  void changeThemeBrightness(Brightness value) {
    _brightness = value;
    state = state.copyWith(brightness: value);
  }

  void switchBrightness() {
    ref
        .read(previousBrightnessProvider.notifier)
        .update((_) => state.brightness);

    state = state.copyWith(
        brightness: state.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
