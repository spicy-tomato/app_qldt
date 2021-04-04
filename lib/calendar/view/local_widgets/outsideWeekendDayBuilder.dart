import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';

Widget outsideWeekendWidget(DateTime date) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
    ),
    child: Center(
      child: Text(
        '${date.day}',
        style: const TextStyle(
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarOutsideWeekendBackgroundColor,
        ),
      ),
    ),
  );
}
