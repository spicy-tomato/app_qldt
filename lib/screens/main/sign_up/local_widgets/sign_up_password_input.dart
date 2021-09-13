part of 'local_widgets.dart';

class SignUpPasswordInput extends StatefulWidget {
  final FocusNode focusNode;

  const SignUpPasswordInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  _SignUpPasswordInputState createState() => _SignUpPasswordInputState();
}

class _SignUpPasswordInputState extends State<SignUpPasswordInput> {
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
        BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) {
            return previous.password != current.password ||
                previous.hidePassword != current.hidePassword ||
                previous.status != current.status;
          },
          builder: (context, state) {
            return TextField(
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
              onChanged: _onChange,
              onSubmitted: _onSubmit,
            );
          },
        ),
        if (passwordFocusNode.hasFocus)
          IconButton(
            icon: const Icon(Icons.remove_red_eye),
            iconSize: 20,
            onPressed: _onPressed,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        else
          Container()
      ],
    );
  }

  void _onChange(String password) {
    context.read<SignUpBloc>().add(SignUpPasswordChanged(password));
  }

  void _onSubmit(String _) {
    widget.focusNode.unfocus();
  }

  void _onPressed() {
    if (!context.read<SignUpBloc>().state.status.isSubmissionInProgress) {
      passwordFocusNode.requestFocus();
      context.read<SignUpBloc>().add(const SignUpPasswordVisibleChanged());
    }
  }
}
