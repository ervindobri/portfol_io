import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'custom_painter.dart';

class BackgroundShape extends StatelessWidget {
  final Color? color;
  final Offset? offset;

  final List<Color>? colors;
  final Alignment? begin;
  final Alignment? end;

  const BackgroundShape({Key? key, this.color, this.offset = Offset.zero, this.colors, this.begin, this.end}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: Get.height,
        width: Get.width,
      ),
      painter: CurvePainter(
        offset: offset,
        color: color,
        colors: colors,
        begin: begin,
        end: end
      ),
    );
  }
}
