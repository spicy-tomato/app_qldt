import 'package:flutter/material.dart';

class WeekendWidget extends StatelessWidget {
  final DateTime date;

  const WeekendWidget({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
