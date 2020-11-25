import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Mt App",
    home: MyScaffold(),
  ));
}

class MyAppBar extends StatelessWidget {
  MyAppBar([this.title]);
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.lightBlue),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: "Navigation menu",
            onPressed: null,

          ),

          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "search",
            onPressed: null,
          )
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Column(
        children: [
          MyAppBar(
            Text(
              'Trang Chủ',
              // ignore: deprecated_member_use
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),

          Container(
            height: 500.0,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(color: Colors.lightGreen),

            child: Column(
              children: <Widget>[
                Image.asset('img/nxb2.jpg',width: 400.0,height: 200.0,),
                Column (
                  children: [
                    Text('Hello world'),
                  ],
                ),
              ],

            ),
          )
        ],
      ),
    );
  }

}


