import 'package:flutter/material.dart';

class OutsideDayWidget extends StatelessWidget {
  final DateTime date;

  const OutsideDayWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
