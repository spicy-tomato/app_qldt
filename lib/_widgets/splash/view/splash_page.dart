import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final bool shouldLoadAfterLogin;

  const SplashPage(
    this.shouldLoadAfterLogin, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 270,
              height: 270,
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
            Column(children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 50,),
              shouldLoadAfterLogin
                  ? Column(
                      children: <Widget>[
                        Text(
                          'Đang tải dữ liệu, vui lòng chờ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).backgroundColor),
                        ),
                        Text(
                          '* Bước này chỉ xảy ra một lần sau khi đăng nhập',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ]),
          ],
        ),
      ),
    );
  }
}
