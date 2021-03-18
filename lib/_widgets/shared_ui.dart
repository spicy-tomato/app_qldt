import 'package:flutter/material.dart';

import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/topbar/topbar.dart';

class SharedUI extends StatelessWidget {
  final Widget child;
  final Widget? topRightWidget;

  const SharedUI({
    Key? key,
    required this.child,
    this.topRightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Sidebar(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TopBar(topRightWidget: topRightWidget),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
