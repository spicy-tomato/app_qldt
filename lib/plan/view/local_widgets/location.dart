import 'package:flutter/material.dart';
import 'shared/shared.dart';

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: TextField(
        style: PlanPageConstant.textFieldStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Vị trí',
          hintStyle: PlanPageConstant.hintTextFieldStyle,
        ),
      ),
    );
  }
}
