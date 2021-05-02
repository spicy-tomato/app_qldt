import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'style/style.dart';

class UsernameInput extends StatelessWidget {
  final FocusNode focusNode;

  const UsernameInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_usernameInput_textField'),
            style: const FormTextStyle(),
            decoration: InputDecoration(
              labelText: 'Mã sinh viên',
              errorText: state.username.invalid ? 'Hãy nhập mã sinh viên' : null,
            ),
            onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => focusNode.nextFocus(),
          );
        },
      ),
    );
  }
}
