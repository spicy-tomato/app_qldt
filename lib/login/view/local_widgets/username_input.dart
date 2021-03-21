import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'style/style.dart';

class UsernameInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return SizedBox(
          height: 80,
          child: TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            style: const FormTextStyle(),
            decoration: InputDecoration(

              labelText:  'Mã sinh viên',
              errorText:
                  state.username.invalid ? 'Hãy nhập mã sinh viên' : null,
            ),

          ),
        );
      },
    );
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   Object? icon;
  //   properties.add(DiagnosticsProperty('icon', icon));
  // }
}
