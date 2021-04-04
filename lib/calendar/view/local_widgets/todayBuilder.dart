import 'package:app_qldt/_utils/const.dart';
import 'package:flutter/material.dart';

Widget todayInNowVisibleWidget(DateTime date) {
  return Container(
    decoration: BoxDecoration(
      color: Const.calendarTodayBackgroundColor,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Center(
      child: Text(
        '${date.day}',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarTodayTextColor,
        ),
      ),
    ),
  );
}

Widget todayOutNowVisibleWidget(DateTime date) {
  return Container(
    decoration: BoxDecoration(
      color: Const.calendarOutsideTodayBackgroundColor,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Center(
      child: Text(
        '${date.day}',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarTodayTextColor,
        ),
      ),
    ),
  );
}
