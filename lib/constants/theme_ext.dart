import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color? get backgroundColor => Theme.of(this).backgroundColor;
  TextStyle? get bodyText1 => Theme.of(this).textTheme.bodyText1;
  TextStyle? get bodyText2 => Theme.of(this).textTheme.bodyText2;
  TextStyle? get headline1 => Theme.of(this).textTheme.headline1;
  TextStyle? get headline2 => Theme.of(this).textTheme.headline2;
  TextStyle? get headline3 => Theme.of(this).textTheme.headline3;
  TextStyle? get headline4 => Theme.of(this).textTheme.headline4;
  TextStyle? get headline5 => Theme.of(this).textTheme.headline5;
  TextStyle? get headline6 => Theme.of(this).textTheme.headline6;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
}
