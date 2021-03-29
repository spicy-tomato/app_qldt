import 'package:flutter/material.dart';

class TodayInNowVisibleWidget extends StatelessWidget {
  final DateTime date;

  const TodayInNowVisibleWidget({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xffD55C7D),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Center(
            child: Text(
              '${date.day}',
              style: const TextStyle(
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayOutNowVisibleWidget extends StatelessWidget {
  final DateTime date;

  const TodayOutNowVisibleWidget({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Color(0xffD55C7D),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Center(
            child: Text(
              '${date.day}',
              style: const TextStyle(
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}
