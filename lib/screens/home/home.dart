import 'package:app_qldt/screens/home/local_widgets/calendar.dart';
import 'package:app_qldt/widgets/interface.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Interface(
      title: 'Trang chủ',
      child: Calendar(),
    );
  }
}
