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
        TextField(
          style: const FormTextStyle(),
          focusNode: passwordFocusNode,
          textInputAction: TextInputAction.done,
          // enabled: !state.status.isSubmissionInProgress,
          // obscureText: state.hidePassword,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            // errorText: state.password.invalid ? 'Hãy nhập mật khẩu' : null,
            contentPadding: const EdgeInsets.only(right: 48),
          ),
          onChanged: _onChange,
          onSubmitted: _onSubmit,
        ),
        Opacity(
          opacity: passwordFocusNode.hasFocus ? 1 : 0,
          child: IconButton(
            icon: const Icon(Icons.remove_red_eye),
            iconSize: 20,
            onPressed: _onPressed,
          ),
        ),
      ],
    );
  }

  void _onChange(String password) {}

  void _onSubmit(String _) {}

  void _onPressed() {}
}
