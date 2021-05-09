import 'package:app_qldt/_widgets/topbar/topbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnstableButton extends StatelessWidget {
  final GlobalKey tooltipKey = GlobalKey();

  @override
  Key? get key => super.key;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: tooltipKey,
      verticalOffset: 20,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        left: 100,
        right: 20,
      ),
      message: 'Chức năng đang trong quá trình phát triển, có thể hoạt động không ổn định',
      child: TopBarItem(
        icon: Icons.info_outline_rounded,
        onTap: () {
          final dynamic tooltip = tooltipKey.currentState;
          tooltip.ensureTooltipVisible();
        },
      ),
    );
  }
}
