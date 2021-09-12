import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BelowPainter extends CustomPainter {
  final BuildContext context;

  BelowPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    final Path path = Path();
    final Paint paint = Paint();
    paint.color = themeData.primaryTextColor;

    path.moveTo(38, 0);
    path.cubicTo(-18, 0, 0, 56, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
