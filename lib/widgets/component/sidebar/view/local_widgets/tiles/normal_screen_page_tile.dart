import 'package:app_qldt/enums/config/screen.dart';
import 'package:flutter/material.dart';

import 'other_screen_page_tile.dart';

class NormalScreenPageTile extends OtherScreenPageTile {
  NormalScreenPageTile(
    BuildContext context, {
    Key? key,
    required ScreenPage screenPage,
  }) : super(
          context,
          key: key,
          screenPage: screenPage,
        );
}
