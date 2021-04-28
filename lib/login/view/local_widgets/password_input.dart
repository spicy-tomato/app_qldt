import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'style/style.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) {
              return previous.password != current.password ||
                  previous.hidePassword != current.hidePassword;
            },
            builder: (context, state) {
              return TextField(
                key: const Key('loginForm_passwordInput_textField'),
                onChanged: (password) =>
                    context.read<LoginBloc>().add(LoginPasswordChanged(password)),
                style: const FormTextStyle(),
                obscureText: state.hidePassword,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  errorText: state.password.invalid ? 'Invalid password' : null,
                  contentPadding: const EdgeInsets.only(right: 48),
                ),
              );
            },
          ),
          IconButton(
            iconSize: 20,
            icon: Icon(Icons.remove_red_eye),
            onPressed: () => context.read<LoginBloc>().add(PasswordVisibleChanged()),
          )
        ],
      ),
    );
  }
}
