import 'package:flutter/material.dart';
import 'package:app_qldt/utils/const.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Const.sideBarBackgroundColor,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              child: DrawerHeader(
                child: Stack(
                  children: [
                    Text('Sidebar'),
                    Align(
                      alignment: Alignment(1, -0.7),
                      child: InkWell(
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: Const.sideBarIconSize,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.blue),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
