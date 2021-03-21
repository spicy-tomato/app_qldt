import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'style/style.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            style: const FormTextStyle(),
            decoration: InputDecoration(
              // Icons(Icons.lock              // ),
                labelText: 'Mật khẩu',


                errorText: state.password.invalid ? 'Invalid password' : null),
          ),
        );
      },
    );
  }
}
