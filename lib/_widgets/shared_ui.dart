import 'package:flutter/material.dart';

import 'package:app_qldt/_widgets/sidebar/sidebar.dart';
import 'package:app_qldt/_widgets/topbar/topbar.dart';

class SharedUI extends StatelessWidget {
  final Widget child;
  final Widget? topRightWidget;
  final BoxDecoration? decoration;

  const SharedUI({
    Key? key,
    required this.child,
    this.decoration,
    this.topRightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Sidebar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 60),
              decoration: decoration ?? BoxDecoration(),
              child: WillPopScope(
                child: child,
                onWillPop: () => _onWillPop(context),
              ),
            ),
            TopBar(topRightWidget: topRightWidget),
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
