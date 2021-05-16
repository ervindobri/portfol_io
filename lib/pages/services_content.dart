import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfol_io/constants/theme_utils.dart';

class ServicesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ThemeUtils.bezier1, ThemeUtils.darkGrey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        )
      ),
    );
  }
}
