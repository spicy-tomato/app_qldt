part of 'local_widgets.dart';

class SignUpCancelButton extends StatefulWidget {
  const SignUpCancelButton({Key? key}) : super(key: key);

  @override
  _SignUpCancelButtonState createState() => _SignUpCancelButtonState();
}

class _SignUpCancelButtonState extends State<SignUpCancelButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Hủy bỏ'),
      onPressed: _onPressed,
    );
  }

  void _onPressed() {
    Navigator.of(context).pop();
  }
}
