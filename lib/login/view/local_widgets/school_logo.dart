import 'package:flutter/material.dart';

class SchoolLogo extends StatelessWidget {
  const SchoolLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 625,
      height: 170,
      child: Hero(
        tag: 'login',
        child: Image.asset('images/bia.jpg'),
      ),
    );
  }
}
