import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';

import 'local_widgets/local_widgets.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("Thông tin"),
                content: Text("Đăng nhập thất bại"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
                    child: const Text("Đồng ý"),
                  )
                ],
              );
            },
          );
        }
      },
      buildWhen: (previous, current) {
        return previous.hideLoginDialog != current.hideLoginDialog ||
            previous.hideKeyboard != current.hideKeyboard;
      },
      builder: (_, state) {
        final focusNode = FocusScope.of(context);

        return AnimatedContainer(
          padding: const EdgeInsets.all(32),
          width: screenWidth,
          height: screenHeight,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(
              0,
              state.hideLoginDialog
                  ? 750
                  : state.hideKeyboard
                      ? 270
                      : 170,
              1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "Đăng nhập để tiếp tục",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  UsernameInput(focusNode: focusNode),
                  const SizedBox(height: 20),
                  PasswordInput(focusNode: focusNode),
                  const SizedBox(height: 20),
                  LoginButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
