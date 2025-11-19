import 'package:flutter/material.dart';

class GlobalColors {
  static const Color primaryColor = Color(0xff222222);
  static const Color white = Color(0xffffffff);
  static const Color green = Color(0xff198294);
  static const Color lightGrey = Color(0xff7B7D7D);
  static const Color darkGrey = Color(0xff161616);

  static const Color bezier1 = Color(0xff111111);
  static const Color bezier2 = Color(0xff535353);
  static const Color bezier3 = Color(0xff393939);

  static LinearGradient greyGradient = const LinearGradient(
      colors: [GlobalColors.lightGrey, GlobalColors.darkGrey],
      stops: [0.01, .69],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft);

  static LinearGradient greenGradient = LinearGradient(
    colors: [GlobalColors.green.withAlpha(110), GlobalColors.white],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Color defaultThemeColor = const Color(0xffF15E3D);

  // Text colors
  static const Color textColorDark = Color(0xff222222);
  static const Color inverseTextColorDark = textColorLight;
  static const Color textColorLight = Color(0xffffffff);
  static const Color inverseTextColorLight = textColorDark;

  static const Color containerColorDark = Color(0xff2b2b2b);
  static const Color containerColorLight = Color(0xffFBFBFB);

  // BG Colors
  static const Color backgroundColorDark = Color(0xff222222);
  static const Color backgroundColorLight = Color(0xffEDEDED);

  static List<Color> themeColors = [
    const Color(0xffF15E3D),
    const Color(0xff3DF1D1),
    const Color(0xff2655E0),
    const Color(0xffB83DF1),
    const Color(0xffF1483D),
  ];

  static const Brightness defaultBrightness = Brightness.dark;
}
