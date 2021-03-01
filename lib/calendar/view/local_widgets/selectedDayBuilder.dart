import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';

Widget selectedDayWidget(
    DateTime date, AnimationController animationController) {
  return Container(
    child: Stack(
      children: <Widget>[
        FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: Container(
            decoration: BoxDecoration(
              color: Const.calendarSelectedBackgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Center(
          child: Text(
            '${date.day}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Const.calendarDayFontSize,
              color: Const.calendarSelectedDayTextColor,
            ),
          ),
        ),
      ],
    ),
  );
}
