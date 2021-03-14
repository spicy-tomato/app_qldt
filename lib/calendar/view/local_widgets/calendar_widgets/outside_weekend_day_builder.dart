import 'package:flutter/material.dart';

class OutsideWeekendWidget extends StatelessWidget {
  final DateTime date;

  const OutsideWeekendWidget({
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
          style: TextStyle(
            fontWeight: FontWeight.w200,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
