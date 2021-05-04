import 'package:flutter/material.dart';

import 'shared/shared.dart';

class Accessibility extends StatefulWidget {
  @override
  _AccessibilityState createState() => _AccessibilityState();
}

class _AccessibilityState extends State<Accessibility> {
  late String display = 'Mặc định';
  List _listItem = ['Công khai', 'Mặc định', 'Riêng tư'];

  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      leading: Icon(Icons.lock_outline),
      title: DropdownButton(
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
        items: _listItem.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: PlanPageConstant.of(context).textFieldStyle,
            ),
          );
        }).toList(),
      ),
    );
  }
}
