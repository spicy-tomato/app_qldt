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
              child: child,
            ),
            TopBar(topRightWidget: topRightWidget),
          ],
        ),
      ),
    );
  }
}
