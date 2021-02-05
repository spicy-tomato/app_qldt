import 'package:app_qldt/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:app_qldt/widgets/sidebar.dart';

class Interface extends StatelessWidget {
  final Widget child;
  final String title;

  final GlobalKey<ScaffoldState> _uiKey = new GlobalKey<ScaffoldState>();

  Interface({Key key, @required this.child, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _uiKey,
        backgroundColor: Const.interfaceBackgroundColor,
        body: Container(
          child: Stack(
            children: [
              TopBar(
                title: title,
                onPressed: () => _uiKey.currentState.openDrawer(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height *
                      Const.contentTopPaddingRatio,
                  left: MediaQuery.of(context).size.width *
                      Const.contentLeftPaddingRatio,
                  right: MediaQuery.of(context).size.width *
                      Const.contentRightPaddingRatio,
                ),
                child: child,
              )
            ],
          ),
        ),
        drawer: Sidebar(),
      ),
    );
  }

  static SizedBox mediumBox() {
    return SizedBox(height: 20.0);
  }
}
