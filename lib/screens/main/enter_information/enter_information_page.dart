import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EnterInformationPage extends StatelessWidget {
  const EnterInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Xác thực thành công!',
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              const SizedBox(height: 5),
            const Text('Hãy nhập một số thông tin dưới đây\n để hoàn tất đăng ký'),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
