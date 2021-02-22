import 'package:flutter/material.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  child: Row(
                    children: [Image.asset('images/avatar.jpg')],
                  ),
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
                title: new Text('Firebase'),
                onTap: () {
                  Navigator.pop(context, '/firebase');
                }),
            new ListTile(
                title: new Text('Logout'),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('student_id');
                  Navigator.pushNamed(context, 'login');
                }),
          ],
        ),
      ),
    );
  }
}
