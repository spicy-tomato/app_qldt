import 'package:flutter/material.dart';

import 'painter/painter.dart';
import 'screen_page_tile.dart';

class AboveEmptyTile extends ScreenPageTile {
  AboveEmptyTile(
    BuildContext context, {
    Key? key,
  }) : super(
          key: key,
          painter: AbovePainter(context),
          empty: true,
        );
}
