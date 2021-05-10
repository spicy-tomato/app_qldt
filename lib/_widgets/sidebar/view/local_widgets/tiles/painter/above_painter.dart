import 'package:flutter/material.dart';

class AbovePainter extends CustomPainter {
  final BuildContext context;

  AbovePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.color = Colors.white;

    path.moveTo(38, 56);
    path.cubicTo(-18, 56, 0, 0, 0, 56);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
