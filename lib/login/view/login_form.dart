import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'local_widgets/local_widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showedDialog = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state.status.isSubmissionFailure && !_showedDialog) {
          _showedDialog = true;
          print('rebuild');
          await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => _loginFailedDialog(context),
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
                  ? screenHeight
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
                  LoginButton(focusNode),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _loginFailedDialog(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: AlertDialog(
        title: Text("Thông tin"),
        content: Text("Đăng nhập thất bại"),
        actions: [
          TextButton(
            onPressed: () {
              _showedDialog = false;
              Navigator.of(context).pop();
            },
            child: const Text("Đồng ý"),
          )
        ],
      ),
    );
  }
}
