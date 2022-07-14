import 'package:flutter/cupertino.dart';

import 'custom_painter.dart';

class BackgroundShape extends StatelessWidget {
  final Color? color;
  final Offset? offset;

  final List<Color>? colors;
  final Alignment? begin;
  final Alignment? end;

  const BackgroundShape(
      {Key? key,
      this.color,
      this.offset = Offset.zero,
      this.colors,
      this.begin,
      this.end})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return CustomPaint(
      child: Container(
        height: height,
        width: width,
      ),
      painter: CurvePainter(
          offset: offset, color: color, colors: colors, begin: begin, end: end),
    );
  }
}
