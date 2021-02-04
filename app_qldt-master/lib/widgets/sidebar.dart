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
            new ListTile(
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
            new UserAccountsDrawerHeader(
                accountName: new Text("MSV:191203380"),
                accountEmail: new Text("trantambcd@gmail.com"),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                )),
            new ListTile(
                title: new Text('HOME'),
                onTap: () {
                  Navigator.pop(context);
                }),
            new ListTile(
                title: new Text('Today'),
                onTap: () {
                  Navigator.pop(context, '/feature/pageone.dart');
                }),
            new ListTile(
                title: new Text('Page two'),
                onTap: () {
                  Navigator.pop(context);
                }),
            new ListTile(
                title: new Text('Page three'),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
