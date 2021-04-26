import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, __, ___) => SplashPage(),
      transitionsBuilder: (context, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: Duration(milliseconds: 1500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: Hero(
                tag: 'loginLogo',
                child: Image.asset(
                  'images/logo.png',
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
