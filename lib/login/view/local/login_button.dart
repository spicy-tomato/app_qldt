import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
                    child: CircularProgressIndicator(),
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
