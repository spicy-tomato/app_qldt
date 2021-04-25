import 'package:flutter/material.dart';

class OutsideDayWidget extends StatelessWidget {
  final DateTime date;

  const OutsideDayWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (date.weekday == DateTime.sunday){
      return Container(
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

    return Container(
      child: Center(
        child: Text(
          '${date.day}',
          style: const TextStyle(
            fontWeight: FontWeight.w200
          ),
        ),
      ),
    );
  }
}
