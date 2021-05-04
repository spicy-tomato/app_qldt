import 'package:flutter/material.dart';

class CommonPadding extends Padding {
  CommonPadding({required Widget child})
      : super(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: child,
        );
}
