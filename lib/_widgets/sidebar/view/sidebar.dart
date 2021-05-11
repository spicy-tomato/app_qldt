import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'local_widgets/local_widgets.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).backgroundColor,
              Color(0xff7579e7),
              Color(0xff9ab3f5),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.9, -0.95),
              child: CloseSidebarButton(),
            ),
            Container(
              width: screenWidth * 0.6,
              padding: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  UserInfo(),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: ScreenPageTilesList(),
                        ),
                        SizedBox(width: screenWidth * 0.15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
