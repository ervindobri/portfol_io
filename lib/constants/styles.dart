import 'package:flutter/material.dart';
import 'package:portfol_io/constants/theme_utils.dart';

class GlobalStyles {
  static ButtonStyle whiteTextButtonStyle() =>
      ButtonStyle(enableFeedback: false);

  static iconButtonStyle() => ButtonStyle(
      overlayColor: MaterialStateProperty.all(GlobalColors.lightGrey),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      // side: MaterialStateProperty.all(BorderSide()),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero)));
}
