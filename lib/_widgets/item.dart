import 'package:flutter/material.dart';
import 'package:app_qldt/_utils/helper/const.dart';

class Item extends StatelessWidget {
  final Widget child;
  final Color color;

  const Item({
    Key? key,
    required this.child,
    this.color = Const.itemBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Const.itemBorderRadius,
        color: color,
      ),
      child: child,
    );
  }
}
