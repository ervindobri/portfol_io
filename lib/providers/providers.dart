import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/providers/theme_notifier.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>(
  (ref) => ThemeNotifier(ref),
);

final themeColorProvider = StateProvider(
  (ref) => ref.watch(themeProvider).primaryColor,
);

final previousThemeColorProvider = StateProvider<Color>(
  (ref) => GlobalColors.defaultThemeColor,
);

final previousBrightnessProvider = StateProvider<Brightness>(
  (ref) => GlobalColors.defaultBrightness,
);
