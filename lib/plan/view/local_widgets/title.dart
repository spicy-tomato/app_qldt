import 'package:flutter/material.dart';

class PlanPageTitle extends StatelessWidget {
  final _textStyle = TextStyle(fontSize: 25);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: TextField(
        style: _textStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Thêm tiêu đề',
          hintStyle: _textStyle,
        ),
      ),
    );
  }
}
