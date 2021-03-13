import 'package:app_qldt/_utils/const.dart';
import 'package:flutter/material.dart';

class SelectedDayWidget extends StatelessWidget {
  final DateTime date;
  final AnimationController animationController;

  SelectedDayWidget(this.date, this.animationController);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
            child: Center(
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Const.calendarDayFontSize,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
