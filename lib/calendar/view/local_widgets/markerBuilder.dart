import 'package:app_qldt/_utils/const.dart';
import 'package:flutter/material.dart';

List<Widget> dayInNowVisibleMonthMarker(DateTime date, List events) {
  final children = <Widget>[];

  if (events.isNotEmpty) {
    children.add(
      Align(
        alignment: Const.calendarMarkerAlignment,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: events
              .take(3)
              .map((_) => Container(
                    width: 6.5,
                    height: 6.5,
                    margin: const EdgeInsets.symmetric(horizontal: 0.5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Const.calendarMarkerColor),
                  ))
              .toList(),
        ),
      ),
    );
  }

  return children;
}

List<Widget> dayOutNowVisibleMonthMarker(DateTime date, List events) {
  final children = <Widget>[];

  if (events.isNotEmpty) {
    children.add(
      Align(
        alignment: Const.calendarMarkerAlignment,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: events
              .take(3)
              .map((_) => Container(
                    width: 6.5,
                    height: 6.5,
                    margin: const EdgeInsets.symmetric(horizontal: 0.5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Const.calendarOutsideMarkerColor,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  return children;
}
