import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/constant/constant.dart';

class SplashPage extends StatelessWidget {
  final bool shouldLoadAfterLogin;

  const SplashPage(
    this.shouldLoadAfterLogin, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 270,
              height: 270,
              child: Hero(
                tag: 'loginLogo',
                child: Image.asset(AppConstant.asset.logo),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Column(children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(
                height: 50,
              ),
              if (shouldLoadAfterLogin)
                Column(
                  children: <Widget>[
                    Text('Đang tải dữ liệu, vui lòng chờ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeData.secondaryTextColor,
                        )),
                    Text(
                      '* Bước này chỉ xảy ra một lần sau khi đăng nhập',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: themeData.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              else
                Container(),
            ]),
          ],
        ),
      ),
    );
  }
}
