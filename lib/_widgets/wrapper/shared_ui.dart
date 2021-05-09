import 'package:flutter/material.dart';

import 'package:app_qldt/_widgets/sidebar/sidebar.dart';
import 'package:app_qldt/_widgets/topbar/topbar.dart';

class SharedUI extends StatelessWidget {
  final Widget child;
  final Widget? topRightWidget;
  final BoxDecoration? decoration;
  final Color? topbarColor;
  final Color? topbariconColor;

  const SharedUI({
    Key? key,
    required this.child,
    this.decoration,
    this.topRightWidget,
    this.topbarColor,
    this.topbariconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Sidebar(),
      body: Container(
        decoration: decoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TopBar(
              topRightWidget: topRightWidget,
              backgroundColor: topbarColor,
              iconColor: topbariconColor,
            ),
            Expanded(
              child: WillPopScope(
                onWillPop: () => _onWillPop(context),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (Navigator.of(context).canPop()) {
      return Future.value(true);
    }

    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Bạn có chắc chắn muốn thoát ứng dụng không?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Có"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Không"),
                ),
              ],
            );
          },
        ) ??
        Future.value(false);
  }
}
