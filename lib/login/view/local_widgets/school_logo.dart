import 'package:flutter/material.dart';

class SchoolLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 625,
      height: 170,

      child: Hero(
        tag: 'login',
        child: Image.asset(
          'images/bia.jpg',
        ),

      ),
    );
  }
}
