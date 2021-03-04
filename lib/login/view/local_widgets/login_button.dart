import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';

import 'package:app_qldt/login/bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return state.status.isSubmissionInProgress
                ? const Center(
                    child: const CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text('Đăng nhập'),
                    onPressed: () {
                      context.read<LoginBloc>().add(const LoginSubmitted());
                    },
                  );
          },
        ),
      ),
    );
  }
}
