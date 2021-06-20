import 'package:flutter/material.dart';

class BelowPainter extends CustomPainter {
  final BuildContext context;

  BelowPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.color = Colors.white;

    path.moveTo(38, 0);
    path.cubicTo(-18, 0, 0, 56, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
