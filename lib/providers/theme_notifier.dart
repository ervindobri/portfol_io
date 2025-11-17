import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/theme.dart';
import 'package:portfol_io/providers/providers.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier(this.ref) : super(PortfolioTheme.defaultDarkTheme);


  Color get themeColor => state.primaryColor;

  final Ref ref;

  void changeThemeColor(Color value) {
    ref
        .read(previousThemeColorProvider.notifier)
        .update((_) => state.primaryColor);
    state = state.copyWith(primaryColor: value);
    if (kDebugMode) {
      print(state.primaryColor);
    }
  }

  void changeThemeBrightness(Brightness value) {
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
