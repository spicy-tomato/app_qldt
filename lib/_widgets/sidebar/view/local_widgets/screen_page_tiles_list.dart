import 'package:app_qldt/_models/screen.dart';
import 'package:app_qldt/_widgets/sidebar/view/local_widgets/tiles/above_empty_tile.dart';
import 'package:app_qldt/_widgets/sidebar/view/local_widgets/tiles/empty_tile.dart';
import 'package:flutter/material.dart';

import 'tiles/tiles.dart';

class ScreenPageTilesList extends StatelessWidget {
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

    List<Widget> _items = _getScreenPagesList(context, currentScreenPage);
    _items.add(_logoutTile(context, currentScreenPage));

    return _items;
  }

  List<Widget> _getScreenPagesList(BuildContext context, ScreenPage currentScreenPage) {
    Widget _firstListItem;

    if (currentScreenPage.index == 1) {
      _firstListItem = AboveEmptyTile(context);
    } else {
      _firstListItem = EmptyTile();
    }

    List<Widget> _list = [_firstListItem];

    for (var screenPage in ScreenPage.values) {
      ///  Chỉ số 0 là trang đăng nhập, vì thế bỏ qua trang này
      if (screenPage.index != 0) {
        if (screenPage.index == currentScreenPage.index) {
          _list.add(CurrentScreenPageTile(screenPage: screenPage));
        } else if (screenPage.index == currentScreenPage.index - 1) {
          _list.add(AboveScreenPageTile(context, screenPage: screenPage));
        } else if (screenPage.index == currentScreenPage.index + 1) {
          _list.add(BelowScreenPageTile(context, screenPage: screenPage));
        } else {
          _list.add(NormalScreenPageTile(context, screenPage: screenPage));
        }
      }
    }

    return _list;
  }

  Widget _logoutTile(BuildContext context, ScreenPage currentScreenPage) {
    if (currentScreenPage.index == ScreenPage.values.length - 1) {
      return BelowCurrentLogoutTile(context);
    }

    return NormalLogoutTile(context);
  }
}
