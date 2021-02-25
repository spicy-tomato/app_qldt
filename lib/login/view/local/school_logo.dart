import 'package:flutter/material.dart';

class SchoolLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.all(15),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xffd8d8d8)),
      child: Row(
        children: [
          Image.asset(
            'images/LogoUTC.jpg',
          )
        ],
      ),
    );
  }
}
