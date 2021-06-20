import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'style/style.dart';

class PasswordInput extends StatelessWidget {
  final FocusNode focusNode;

  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
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
                  errorText: state.password.invalid ? 'Hãy nhập mật khẩu' : null,
                  contentPadding: const EdgeInsets.only(right: 48),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => focusNode.unfocus(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_red_eye),
            iconSize: 20,
            onPressed: () => context.read<LoginBloc>().add(LoginPasswordVisibleChanged()),
          )
        ],
      ),
    );
  }
}
