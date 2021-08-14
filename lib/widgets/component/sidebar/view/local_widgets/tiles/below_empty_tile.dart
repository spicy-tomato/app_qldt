import 'package:flutter/material.dart';

import 'painter/painter.dart';
import 'screen_page_tile.dart';

class BelowEmptyTile extends ScreenPageTile {
  BelowEmptyTile(
    BuildContext context, {
    Key? key,
  }) : super(
          key: key,
          painter: BelowPainter(context),
          empty: true,
        );
}
