import 'package:flutter/material.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/constants/constants.dart';

class PortfolioTheme {
  static ThemeData get defaultDarkTheme => ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: GlobalColors.defaultThemeColor,
        // Define the default font family.
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 36.0,
              color: GlobalColors.textColorDark,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 72.0,
              color: GlobalColors.textColorDark,
              fontWeight: FontWeight.normal),
          headlineSmall: TextStyle(
              fontSize: 36.0,
              color: GlobalColors.textColorDark,
              fontFamily: 'Poppins'),
          headlineMedium: TextStyle(
              fontSize: 48.0,
              color: GlobalColors.textColorDark,
              fontFamily: 'Poppins'),
          bodyMedium: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: GlobalColors.textColorDark),
          bodyLarge: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: GlobalColors.textColorDark,
          ),
          labelLarge: TextStyle(
              fontSize: 18.0,
              color: GlobalColors.textColorDark,
              fontWeight: FontWeight.w300),
          labelMedium: TextStyle(
              fontSize: 16.0,
              color: GlobalColors.textColorDark,
              fontWeight: FontWeight.w300),
          labelSmall: TextStyle(
              fontSize: 14,
              color: GlobalColors.textColorDark,
              fontWeight: FontWeight.w300),
        ),
      );

  static ThemeData get defaultLightTheme => ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: GlobalColors.defaultThemeColor,
        // Define the default font family.
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 36.0,
              color: GlobalColors.textColorDark,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 72.0,
              color: GlobalColors.textColorLight,
              fontWeight: FontWeight.normal),
          headlineSmall: TextStyle(
              fontSize: 36.0,
              color: GlobalColors.textColorLight,
              fontFamily: 'Poppins'),
          headlineMedium: TextStyle(
              fontSize: 48.0,
              color: GlobalColors.textColorLight,
              fontFamily: 'Poppins'),
          bodyMedium: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: GlobalColors.textColorLight),
          bodyLarge: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: GlobalColors.textColorLight,
          ),
          labelLarge: TextStyle(
              fontSize: 18.0,
              color: GlobalColors.textColorLight,
              fontWeight: FontWeight.w300),
          labelMedium: TextStyle(
              fontSize: 16.0,
              color: GlobalColors.textColorLight,
              fontWeight: FontWeight.w300),
          labelSmall: TextStyle(
              fontSize: 14,
              color: GlobalColors.textColorLight,
              fontWeight: FontWeight.w300),
        ),
      );
}
