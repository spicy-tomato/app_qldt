import 'package:flutter/material.dart';

class CalendarDow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Table(
            children: [
              TableRow(children: _daysOfWeek()),
            ],
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _daysOfWeek() {
    List<Widget> _dow = [];

    ['T2', 'T3', 'T4', 'T5', 'T6', 'T7'].forEach((date) {
      _dow.add(_DaysOfWeekDay(date: date));
    });

    _dow.add(_DaysOfWeekend(date: 'CN'));
    return _dow;
  }
}

class _DaysOfWeekDay extends StatelessWidget {
  final String date;

  const _DaysOfWeekDay({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        top: 10,
        bottom: 10,
      ),
      child: Container(
        child: Center(
          child: Text(
            '$date',
            style: Theme.of(context).textTheme.headline6!.merge(
                  TextStyle(color: Color(0xffffffff)),
                ),
          ),
        ),
      ),
    );
  }
}

class _DaysOfWeekend extends StatelessWidget {
  final String date;

  const _DaysOfWeekend({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        top: 10,
        bottom: 10,
      ),
      child: Container(
        child: Center(
          child: Text(
            '$date',
            style: Theme.of(context).textTheme.headline6!.merge(
                  TextStyle(color: Theme.of(context).accentColor),
                ),
          ),
        ),
      ),
    );
  }
}
