import 'package:app_qldt/enums/config/screen.dart';
import 'package:flutter/material.dart';

import 'tiles/tiles.dart';

class ScreenPageTilesList extends StatelessWidget {
  const ScreenPageTilesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 7),
      children: _getSidebarItems(context),
    );
  }

  List<Widget> _getSidebarItems(BuildContext context) {
    ScreenPage currentScreenPage = ScreenPage.login;
    String? currentRoute = ModalRoute.of(context)!.settings.name;

    for (var value in ScreenPage.values) {
      if (value.string == currentRoute) {
        currentScreenPage = value;
        break;
      }
    }

    return _getScreenPagesList(context, currentScreenPage);
  }

  List<Widget> _getScreenPagesList(BuildContext context, ScreenPage currentScreenPage) {
    final _firstListItem = currentScreenPage.index == 1
        //
        ? AboveEmptyTile(context)
        : const EmptyTile();

    final _lastListItem = currentScreenPage.index == ScreenPage.values.length - 2
        //
        ? BelowEmptyTile(context)
        : const EmptyTile();

    List<Widget> _list = [_firstListItem];

    for (int i = 1; i < ScreenPage.values.length - 1; i++) {
      final page = ScreenPage.values[i];

      if (page.index == currentScreenPage.index) {
        _list.add(CurrentScreenPageTile(screenPage: page));
      } else if (page.index == currentScreenPage.index - 1) {
        _list.add(AboveScreenPageTile(context, screenPage: page));
      } else if (page.index == currentScreenPage.index + 1) {
        _list.add(BelowScreenPageTile(context, screenPage: page));
      } else {
        _list.add(NormalScreenPageTile(context, screenPage: page));
      }
    }

    _list.add(_lastListItem);

    return _list;
  }
}
