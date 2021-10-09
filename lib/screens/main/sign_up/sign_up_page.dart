import 'package:flutter/material.dart';

import 'local_widgets/local_widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode focusNode = FocusScope.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            const Positioned(
              left: 15,
              top: 10,
              child: SignUpCancelButton(),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'ĐĂNG KÝ',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Hãy nhập thông tin đăng nhập của bạn \n từ trang qldt.utc.edu.vn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SignUpUsernameInput(focusNode: focusNode),
                    const SizedBox(height: 15),
                    SignUpPasswordInput(focusNode: focusNode),
                    const SizedBox(height: 25),
                    SignUpButton(focusNode),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
