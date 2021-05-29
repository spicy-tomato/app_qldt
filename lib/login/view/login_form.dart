import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:formz/formz.dart';

import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'local_widgets/local_widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late bool showLoginFailedDialog;

  @override
  void initState() {
    super.initState();
    showLoginFailedDialog = false;
  }

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode focusNode = FocusScope.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state.status.isSubmissionFailure &&
            !showLoginFailedDialog &&
            state.shouldShowLoginFailedDialog) {
          showLoginFailedDialog = true;
          context.read<LoginBloc>().add(ShowedLoginFailedDialog());
          await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => _loginFailedDialog(context),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) {
          return previous.hideLoginDialog != current.hideLoginDialog;
        },
        builder: (_, state) {
          return KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
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
                        : isKeyboardVisible
                            ? 170
                            : 270,
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
        },
      ),
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
              showLoginFailedDialog = false;
              Navigator.of(context).pop();
            },
            child: const Text("Đồng ý"),
          )
        ],
      ),
    );
  }
}
