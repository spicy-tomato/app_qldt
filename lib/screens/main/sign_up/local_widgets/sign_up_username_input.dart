part of 'local_widgets.dart';

class SignUpUsernameInput extends StatefulWidget {
  final FocusNode focusNode;

  const SignUpUsernameInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  _SignUpUsernameInputState createState() => _SignUpUsernameInputState();
}

class _SignUpUsernameInputState extends State<SignUpUsernameInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.username != current.username || previous.status != current.status,
        builder: (context, state) {
          return TextField(
            enabled: !state.status.isSubmissionInProgress,
            style: const FormTextStyle(),
            decoration: InputDecoration(
              labelText: 'Mã sinh viên',
              errorText: state.username.invalid ? 'Hãy nhập mã sinh viên' : null,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: _onEditingComplete,
            onChanged: _onChanged,
          );
        },
      ),
    );
  }

  void _onEditingComplete() {
    widget.focusNode.nextFocus();
  }

  void _onChanged(String username) {
    context.read<SignUpBloc>().add(SignUpUsernameChanged(username));
  }
}
