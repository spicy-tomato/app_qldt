import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class CrawlErrorDialog extends StatelessWidget {
  final BuildContext rootContext;

  const CrawlErrorDialog({
    Key? key,
    required this.rootContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
      content: Text('Có lỗi không xác định đã xảy ra, vui lòng khởi động lại ứng dụng'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            print('nfjaksdnf');
            Phoenix.rebirth(context);
          },
          child: Text('Đồng ý'),
        ),
      ],
    );
  }
}
