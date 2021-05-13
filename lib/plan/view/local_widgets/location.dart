import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'shared/shared.dart';

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
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
