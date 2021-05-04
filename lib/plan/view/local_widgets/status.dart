import 'package:flutter/material.dart';

import 'shared/shared.dart';

class Status extends StatefulWidget {
  @override
  StatusState createState() => StatusState();
}

class StatusState extends State<Status> {
  late String status = 'Rảnh';
  List _listItem = ['Rảnh', 'Bận'];

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
          value: status,
          onChanged: (newValue) {
            setState(() {
              status = newValue.toString();
            });
          },
          items: _listItem.map((newValue) {
            return DropdownMenuItem(
              value: newValue,
              child: Text(newValue),
            );
          }).toList()),
    );
  }
}
