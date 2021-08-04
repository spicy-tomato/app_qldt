import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';

import 'package:app_qldt/login/bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  final FocusNode focusNode;

  const LoginButton(this.focusNode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (_, state) {
            return state.status.isSubmissionInProgress ? const ProcessingWidget() : Button(focusNode);
          },
        ),
      ),
    );
  }
}

class ProcessingWidget extends StatelessWidget {
  const ProcessingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Button extends StatelessWidget {
  final FocusNode focusNode;

  const Button(this.focusNode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfb40284a)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      child: const Text('Đăng nhập'),
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.read<LoginBloc>().add(const LoginPasswordVisibleChanged(true));
        context.read<LoginBloc>().add(LoginSubmitted());
      },
    );
  }
}
