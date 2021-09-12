import 'package:app_qldt/widgets/component/topbar/topbar.dart';
import 'package:flutter/material.dart';

class RefreshButton extends TopBarItem {
  const RefreshButton({
    Key? key,
    color,
    required onTap,
  }) : super(
          key: key,
          onTap: onTap,
          icon: Icons.refresh,
        );
}
