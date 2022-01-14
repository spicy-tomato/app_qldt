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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'Xác thực thành công!',
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(height: 5),
              Text('Hãy nhập một số thông tin dưới đây\n để hoàn tất đăng ký'),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
