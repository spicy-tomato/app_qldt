import 'package:flutter/material.dart';

List<Widget> dayInNowVisibleMonthMarker(DateTime date, List events) {
  final children = <Widget>[];

  if (events.isNotEmpty) {
    children.add(
      Align(
        alignment: Alignment(0, 0.6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: events.take(3).map((_) => InsideMarker()).toList(),
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
        alignment: Alignment(0, 0.6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: events.take(3).map((_) => OutsideMarker()).toList(),
        ),
      ),
    );
  }

  return children;
}

class InsideMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6.5,
      height: 6.5,
      margin: const EdgeInsets.symmetric(horizontal: 0.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff4cbbb9),
      ),
    );
  }
}

class OutsideMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6.5,
      height: 6.5,
      margin: const EdgeInsets.symmetric(horizontal: 0.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffb7e4e3),
      ),
    );
  }
}
