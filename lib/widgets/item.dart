import 'package:flutter/material.dart';
import 'package:app_qldt/utils/const.dart';

class Item extends StatelessWidget {
  final Widget child;

  const Item({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: Const.itemBorderRadius,
        color: Const.itemBackgroundColor,
      ),
      child: child,
    );
  }
}
