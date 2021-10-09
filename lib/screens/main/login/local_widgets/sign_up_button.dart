part of 'local_widgets.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: const Text(
          'Bạn chưa có tài khoản? Đăng ký ngay',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    await Navigator.of(context).pushNamed(ScreenPage.signUp.string);
  }
}
