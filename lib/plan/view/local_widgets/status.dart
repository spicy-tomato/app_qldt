import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:flutter/material.dart';

import 'shared/shared.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  StatusState createState() => StatusState();
}

class StatusState extends State<Status> {
  late String status = 'Rảnh';
  final List _listItem = ['Rảnh', 'Bận'];

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: const Icon(Icons.work_outline),
      title: DropdownButton(
        dropdownColor: Colors.grey,
        style: const TextStyle(color: Colors.black, fontSize: 22.0),
        elevation: 5,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 36.0,
        isExpanded: true,
        value: status,
        onChanged: (newValue) {
          setState(() {
            status = newValue.toString();
          });
        },
        items: _listItem.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: PlanPageConstant.textFieldStyle,
            ),
          );
        }).toList(),
      ),
    );
  }
}
