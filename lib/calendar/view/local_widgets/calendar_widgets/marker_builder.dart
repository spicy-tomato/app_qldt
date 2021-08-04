import 'package:app_qldt/_models/user_event_model.dart';
import 'package:flutter/material.dart';

class _RowMarker extends StatelessWidget {
  final List<UserEventModel?> events;
  final Color color;

  const _RowMarker(
    this.events,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (events.isNotEmpty) {
      return Align(
        alignment: const Alignment(0, 0.6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: events.take(3).map((_) => Marker(color)).toList(),
        ),
      );
    }

    return Container();
  }
}

class Marker extends StatelessWidget {
  final Color color;

  const Marker(
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6.5,
      height: 6.5,
      margin: const EdgeInsets.symmetric(horizontal: 0.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class DayInFocusMonthMarker extends _RowMarker {
  const DayInFocusMonthMarker(
    List<UserEventModel?> events, {
    Key? key,
  }) : super(
          events,
          const Color(0xff4cbbb9),
          key: key,
        );
}

class DayOutFocusedMonthMarker extends _RowMarker {
  const DayOutFocusedMonthMarker(
    List<UserEventModel?> events, {
    Key? key,
  }) : super(
          events,
          const Color(0xffb7e4e3),
          key: key,
        );
}
