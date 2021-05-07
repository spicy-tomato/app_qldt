import 'package:flutter/material.dart';

import 'shared/shared.dart';

class Describe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      leading: const Icon(Icons.dehaze_outlined),
      title: TextField(
        style: PlanPageConstant.textFieldStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Mô tả',
          hintStyle: PlanPageConstant.hintTextFieldStyle,
        ),
      ),
    );
  }
}
