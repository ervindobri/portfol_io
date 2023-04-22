import 'package:flutter/material.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/constants/theme_ext.dart';

class GlobalStyles {
  static EdgeInsets get horizontalScreenPadding =>
      const EdgeInsets.symmetric(horizontal: 128);

  static BorderRadius get borderRadius => BorderRadius.circular(8);
  static ButtonStyle whiteTextButtonStyle(
          {Color backgroundColor = Colors.white,
          EdgeInsets padding = EdgeInsets.zero}) =>
      ButtonStyle(
        enableFeedback: false,
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        padding: MaterialStateProperty.all(padding),
      );

  static iconButtonStyle() => ButtonStyle(
        overlayColor: MaterialStateProperty.all(GlobalColors.lightGrey),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        // side: MaterialStateProperty.all(BorderSide()),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      );

  static InputDecoration inputDecoration() => InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(.66),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.white),
        ),
      );

  static primaryButtonStyle(ThemeData theme, Color? themeColor) => ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        overlayColor: MaterialStatePropertyAll(themeColor),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return theme.inverseTextColor;
        }),
      );
}
