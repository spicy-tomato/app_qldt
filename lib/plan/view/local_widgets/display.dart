import 'package:flutter/material.dart';

import 'shared/shared.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  late String display = 'Mặc định';
  List _listItem = ['Công khai', 'Mặc định', 'Riêng tư'];

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
        child: DropdownButton(
            dropdownColor: Colors.grey,
            style: TextStyle(color: Colors.black, fontSize: 22.0),
            elevation: 5,
            icon: new Icon(Icons.arrow_drop_down),
            iconSize: 36.0,
            isExpanded: true,
            value: display,
            onChanged: (newValue) {
              setState(() {
                display = newValue.toString();
              });
            },
            items: _listItem.map((newValue) {
              return DropdownMenuItem(
                value: newValue,
                child: Text(newValue),
              );
            }).toList()));
  }
}
