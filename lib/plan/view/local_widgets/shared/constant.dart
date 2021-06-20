import 'package:flutter/material.dart';

class PlanPageConstant extends InheritedWidget {
  static final _textStyle = TextStyle(
    color: Color(0xff000000),
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle hintTextFieldStyle = _textStyle.copyWith(
    color: Color(0xff616161),
  );

  static final TextStyle textFieldStyle = _textStyle;

  PlanPageConstant({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static PlanPageConstant? of(BuildContext context) {
    final PlanPageConstant? result = context.dependOnInheritedWidgetOfExactType<PlanPageConstant>();
    assert (result != null, 'No PlanPageConstant found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(_) => false;
}
