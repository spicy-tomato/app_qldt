import 'package:flutter/material.dart';

class PlanPageConstant extends InheritedWidget {
  static final _textStyle = TextStyle(
    color: Color(0xff000000),
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  final TextStyle hintTextFieldStyle = _textStyle.copyWith(
    color: Color(0xff616161),
  );

  final TextStyle textFieldStyle = _textStyle;

  PlanPageConstant({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static PlanPageConstant of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PlanPageConstant>()!;

  @override
  bool updateShouldNotify(_) => false;
}
