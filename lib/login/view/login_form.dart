import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/login/login.dart';

import 'local_widgets/local_widgets.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          // Scaffold.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     const SnackBar(
          //       content: Text('Authentication Failure'),
          //     ),
          //   );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: SchoolLogo(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: const Text(
              " LOGIN\n",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: UsernameInput(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: PasswordInput(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: LoginButton(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Container(
              height: 30,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "REMEMBER ME",
                    style: TextStyle(fontSize: 15, color: Color(0xff888888)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "NEW USER ? LOGIN",
                  style: TextStyle(fontSize: 15, color: Color(0xff888888)),
                ),
                const Text(
                  "FORGOT PASSWORD?",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
