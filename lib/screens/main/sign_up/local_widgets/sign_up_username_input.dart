part of 'local_widgets.dart';

class SignUpUsernameInput extends StatelessWidget {
  final FocusNode focusNode;

  const SignUpUsernameInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        // enabled: !state.status.isSubmissionInProgress,
        style: const FormTextStyle(),
        decoration: InputDecoration(
          labelText: 'Mã sinh viên',
          // errorText: state.username.invalid ? 'Hãy nhập mã sinh viên' : null,
        ),
        textInputAction: TextInputAction.next,
        onEditingComplete: () => focusNode.nextFocus(),
        onChanged: _onChanged,
      ),
    );
  }

  void _onChanged(String username) {

  }
}
