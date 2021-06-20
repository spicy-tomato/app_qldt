import 'package:flutter/material.dart';

class Instructor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Để sử dụng chức năng này, bạn cần cung cấp mật khẩu của bạn trên trang qldt.utc.edu.vn',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}
