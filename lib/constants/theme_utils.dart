import 'package:flutter/material.dart';

class GlobalColors {
  static const Color primaryColor = const Color(0xff222222);
  static const Color white = const Color(0xffffffff);
  static const Color green = const Color(0xff198294);
  static const Color lightGrey = const Color(0xff7B7D7D);
  static const Color darkGrey = const Color(0xff161616);

  static const Color bezier1 = const Color(0xff111111);
  static const Color bezier2 = const Color(0xff535353);
  static const Color bezier3 = const Color(0xff393939);

  static LinearGradient greyGradient = const LinearGradient(
      colors: [GlobalColors.lightGrey, GlobalColors.darkGrey],
      stops: [0.01, .69],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft);

  static LinearGradient greenGradient = LinearGradient(
    colors: [GlobalColors.green.withOpacity(.4), GlobalColors.white],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
