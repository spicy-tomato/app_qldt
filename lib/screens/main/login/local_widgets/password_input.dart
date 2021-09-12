part of 'local_widgets.dart';


class PasswordInput extends StatefulWidget {
  final FocusNode focusNode;

  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) {
            return previous.password != current.password ||
                previous.hidePassword != current.hidePassword ||
                previous.status != current.status;
          },
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_passwordInput_textField'),
              style: const FormTextStyle(),
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.done,
              enabled: !state.status.isSubmissionInProgress,
              obscureText: state.hidePassword,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                errorText: state.password.invalid ? 'Hãy nhập mật khẩu' : null,
                contentPadding: const EdgeInsets.only(right: 48),
              ),
              onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
              onSubmitted: (_) => widget.focusNode.unfocus(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove_red_eye),
          iconSize: 20,
          onPressed: () {
            if (!context.read<LoginBloc>().state.status.isSubmissionInProgress) {
              passwordFocusNode.requestFocus();
              context.read<LoginBloc>().add(const LoginPasswordVisibleChanged());
            }
          },
        )
      ],
    );
  }
}
