import 'package:app_qldt/_models/screen.dart';
import 'package:flutter/material.dart';

import 'screen_page_tile.dart';

class CurrentScreenPageTile extends ScreenPageTile {
  const CurrentScreenPageTile({
    Key? key,
    required ScreenPage screenPage,
  }) : super(
          key: key,
          screenPage: screenPage,
          current: true,
        );
}
