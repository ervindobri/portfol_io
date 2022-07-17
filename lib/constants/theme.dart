import 'package:flutter/material.dart';
import 'package:portfol_io/constants/theme_utils.dart';

class PortfolioTheme {
  static ThemeData get theme => ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: GlobalColors.primaryColor,
        // Define the default font family.
        fontFamily: 'Helvetica',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 32.0, fontWeight: FontWeight.normal),
          headline5: TextStyle(fontSize: 36.0, fontFamily: 'Helvetica'),
          headline4: TextStyle(fontSize: 48.0, fontFamily: 'Helvetica'),
          bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w300),
          bodyText1: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w200),
          labelMedium: TextStyle(fontSize: 20.0, fontFamily: 'Helvetica'),
        ),
      );
}
