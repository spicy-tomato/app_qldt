import 'package:app_qldt/_widgets/topbar/topbar.dart';
import 'package:flutter/material.dart';

class RefreshButton extends TopBarItem {
  final Function() onTap;
  final BuildContext context;
  final Color? color;

  RefreshButton(
    this.context, {
    this.color,
    required this.onTap,
  }) : super(
          onTap: onTap,
          alignment: Alignment(0.95, 0),
          icon: Icons.refresh,
          color: color,
        );
}
