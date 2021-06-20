import 'package:app_qldt/_models/screen.dart';
import 'package:flutter/material.dart';

import 'other_screen_page_tile.dart';
import 'painter/painter.dart';

class BelowScreenPageTile extends OtherScreenPageTile {
  BelowScreenPageTile(
    BuildContext context, {
    Key? key,
    required ScreenPage screenPage,
  }) : super(
          context,
          key: key,
          screenPage: screenPage,
          painter: BelowPainter(context),
        );
}
