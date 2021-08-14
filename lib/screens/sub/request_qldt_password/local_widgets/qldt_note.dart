import 'package:flutter/material.dart';

class QldtNote extends StatelessWidget {
  const QldtNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '* Quá trình này có thể lên đến năm phút',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).backgroundColor,
        fontSize: 14,
      ),
    );
  }
}
