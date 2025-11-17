import 'package:flutter/cupertino.dart';

class CurvePainter extends CustomPainter {
  final Color? color;
  final Offset? offset;

  final List<Color>? colors;
  final Alignment? begin;
  final Alignment? end;

  CurvePainter(
      {this.begin,
      this.end,
      this.colors,
      this.offset = Offset.zero,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    const height = 1080;
    if (colors != null && begin != null && end != null) {
      paint.shader = LinearGradient(
        colors: colors!,
        begin: begin!,
        end: end!,
      ).createShader(Rect.fromCenter(
          center: Offset(size.width * .3, height / 2),
          // radius: 25,
          width: size.width,
          height: size.height));
    } else {
      paint.color = color!;
    }
    path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * .3 + offset!.dx * 1.2, size.height);
    path.quadraticBezierTo(
        size.width * 0.38 + offset!.dx,
        size.height * 0.8 + offset!.dy,
        size.width * 0.36 + offset!.dx,
        size.height * 0.60 + offset!.dy);
    path.quadraticBezierTo(
        size.width * 0.33 + offset!.dx,
        size.height * .15 + offset!.dy,
        size.width * 0.53 + offset!.dx,
        size.height * .225 + offset!.dy);
    path.quadraticBezierTo(size.width * 0.65 + offset!.dx,
        size.height * .27 + offset!.dy, size.width * .9 + offset!.dx, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
