import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final DateTime date;

  const DayWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('${date.day}'),
      ),
    );
  }
}
