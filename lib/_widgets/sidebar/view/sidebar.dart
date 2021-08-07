import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'local_widgets/local_widgets.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/sidebar.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment(0.9, -0.95),
              child: CloseSidebarButton(),
            ),
            Container(
              width: screenWidth * 0.7,
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const UserInfo(),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Flexible(
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
