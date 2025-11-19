import 'package:flutter/material.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/extensions/theme_ext.dart';

class GlobalStyles {
  static EdgeInsets get horizontalScreenPadding =>
      const EdgeInsets.symmetric(horizontal: 128);

  static BorderRadius get borderRadius => BorderRadius.circular(8);
  static ButtonStyle whiteTextButtonStyle(
          {Color backgroundColor = Colors.white,
          EdgeInsets padding = EdgeInsets.zero}) =>
      ButtonStyle(
        enableFeedback: false,
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        padding: WidgetStateProperty.all(padding),
      );

  static iconButtonStyle() => ButtonStyle(
        overlayColor: WidgetStateProperty.all(GlobalColors.lightGrey),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        // side: MaterialStateProperty.all(BorderSide()),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      );

  static InputDecoration inputDecoration() => InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        filled: true,
        fillColor: Colors.black.withAlpha(170),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.white),
        ),
      );

  static ButtonStyle primaryButtonStyle(ThemeData theme) => ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        splashFactory: NoSplash.splashFactory,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return theme.primaryColor;
            }
            return theme.inverseTextColor;
          },
        ),
      );

  static BorderRadius get homeRadius => const BorderRadius.only(
        topLeft: Radius.circular(128),
        bottomLeft: Radius.circular(128),
        topRight: Radius.circular(24),
        bottomRight: Radius.circular(24),
      );

  static textButtonPadding() => const EdgeInsets.fromLTRB(24, 12, 24, 12);
}
