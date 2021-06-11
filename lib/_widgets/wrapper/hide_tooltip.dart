import 'package:flutter/material.dart';

class HideTooltip extends StatelessWidget {
  final Widget child;

  const HideTooltip({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        //  Hide tooltip
        data: Theme.of(context).copyWith(
            tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: Colors.transparent))),
        child: child);
  }
}
