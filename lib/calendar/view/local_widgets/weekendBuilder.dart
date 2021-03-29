import 'package:app_qldt/_utils/const.dart';
import 'package:flutter/material.dart';

Widget weekendWidget(DateTime date) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
    ),
    child: Center(
      child: Text(
        '${date.day}',
        style: const TextStyle(
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarWeekendBackgroundColor,
        ),
      ),
    ),
  );
}
