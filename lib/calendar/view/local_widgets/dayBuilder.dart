import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';

Widget dayWidget(DateTime date) {
  return Container(
    child: Center(
      child: Text(
        '${date.day}',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarTextColor,
        ),
      ),
    ),
  );
}
