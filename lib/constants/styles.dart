import 'package:flutter/material.dart';
import 'package:portfol_io/constants/theme_utils.dart';

class GlobalStyles {
  static ButtonStyle whiteTextButtonStyle(
          {Color backgroundColor = Colors.white,
          EdgeInsets padding = EdgeInsets.zero}) =>
      ButtonStyle(
        enableFeedback: false,
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        padding: MaterialStateProperty.all(padding),
      );

  static iconButtonStyle() => ButtonStyle(
      overlayColor: MaterialStateProperty.all(GlobalColors.lightGrey),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      // side: MaterialStateProperty.all(BorderSide()),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero)));
}
