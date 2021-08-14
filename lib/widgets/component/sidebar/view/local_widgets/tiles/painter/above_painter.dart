import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbovePainter extends CustomPainter {
  final BuildContext context;

  AbovePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    Path path = Path();
    Paint paint = Paint();
    paint.color = themeData.primaryTextColor;

    path.moveTo(38, 56);
    path.cubicTo(-18, 56, 0, 0, 0, 56);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
