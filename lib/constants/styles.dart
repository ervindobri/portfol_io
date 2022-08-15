import 'package:flutter/material.dart';
import 'package:portfol_io/constants/colors.dart';

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
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      );

  static InputDecoration inputDecoration() => InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(.66),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.white),
        ),
      );
}
