import 'package:flutter/material.dart';

// ignore: camel_case_types
class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 625,
      height: 150,

      child: Hero(
        tag: 'login',
        child: Image.asset(
          'images/footer.jpg',
        ),

      ),
    );
  }
}
