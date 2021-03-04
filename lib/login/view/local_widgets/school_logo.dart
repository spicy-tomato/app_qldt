import 'package:flutter/material.dart';

class SchoolLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(15),
      child: Hero(
        tag: 'loginLogo',
        child: Image.asset(
          'images/LogoUTC.jpg',
        ),
      ),
    );
  }
}
