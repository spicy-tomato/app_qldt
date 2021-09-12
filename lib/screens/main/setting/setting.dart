import 'package:app_qldt/widgets/component/list_tile/custom_list_tile.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cài đặt'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            CustomListTile(
              title: TextFormField(
                  // initialValue: ,
                  ),
            )
          ],
        )),
      ),
    );
  }
}
