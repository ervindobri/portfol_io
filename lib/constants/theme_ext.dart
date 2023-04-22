import 'package:flutter/material.dart';
import 'package:portfol_io/constants/colors.dart';

extension ThemeExtension on BuildContext {
  Color? get backgroundColor => Theme.of(this).colorScheme.background;
  TextStyle? get bodyText1 => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyText2 => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get headline1 => Theme.of(this).textTheme.displayLarge;
  TextStyle? get headline2 => Theme.of(this).textTheme.displayMedium;
  TextStyle? get headline3 => Theme.of(this).textTheme.displaySmall;
  TextStyle? get headline4 => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headline5 => Theme.of(this).textTheme.headlineSmall;
  TextStyle? get headline6 => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
}

extension ThemeDataExt on ThemeData {
  Color get containerColor => brightness == Brightness.dark
      ? GlobalColors.containerColorDark
      : GlobalColors.containerColorLight;

  Color get inverseTextColor => brightness == Brightness.dark
      ? GlobalColors.inverseTextColorDark
      : GlobalColors.inverseTextColorLight;

    Color get textColor => brightness == Brightness.dark
      ? GlobalColors.textColorDark
      : GlobalColors.textColorLight;

  TextStyle? get inverseBodyLarge =>
      textTheme.bodyLarge?.copyWith(color: inverseTextColor);

  TextStyle? get nameStyleLarge => textTheme.displayLarge?.copyWith(
        color: inverseTextColor,
        fontSize: 96,
        height: 1.1,
        fontWeight: FontWeight.w700,
      );
  TextStyle? get nameStyleSmall => textTheme.displayLarge?.copyWith(
        color: inverseTextColor,
        fontSize: 48,
        height: 1.05,
        fontWeight: FontWeight.w300,
      );

  Color get extBackgroundColor => brightness == Brightness.dark
      ? GlobalColors.backgroundColorDark
      : GlobalColors.backgroundColorLight;
}

extension BrightnessExtension on Brightness {
    Color get extBackgroundColor => this == Brightness.dark
      ? GlobalColors.backgroundColorDark
      : GlobalColors.backgroundColorLight;
}
