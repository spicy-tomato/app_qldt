part of 'local_widgets.dart';

class SignUpButton extends StatelessWidget {
  final FocusNode focusNode;

  const SignUpButton(this.focusNode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
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

class Button extends StatefulWidget {
  final FocusNode focusNode;

  const Button(this.focusNode, {Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfb40284a)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      child: const Text('Đăng ký'),
      onPressed: _onPressed,
    );
  }

  void _onPressed() {
    FocusScope.of(context).unfocus();
    context.read<SignUpBloc>().add(const SignUpPasswordVisibleChanged(true));
    context.read<SignUpBloc>().add(SignUpSubmitted());
  }
}
