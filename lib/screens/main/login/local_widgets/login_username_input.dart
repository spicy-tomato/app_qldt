part of 'local_widgets.dart';

class LoginUsernameInput extends StatelessWidget {
  final FocusNode focusNode;

  const LoginUsernameInput({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BlocBuilder<LoginBloc, LoginState>(
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
            onEditingComplete: () => focusNode.nextFocus(),
            onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          );
        },
      ),
    );
  }
}
