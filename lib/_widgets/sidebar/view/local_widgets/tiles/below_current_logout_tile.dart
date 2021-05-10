import 'package:app_qldt/_widgets/sidebar/view/local_widgets/tiles/painter/below_painter.dart';
import 'package:flutter/material.dart';

import 'logout_tile.dart';

class BelowCurrentLogoutTile extends LogoutTile {
  BelowCurrentLogoutTile(
    BuildContext context, {
    Key? key,
  }) : super(
          context,
          key: key,
          painter: BelowPainter(context),
        );
}
