import 'package:app_qldt/blocs/authentication/authentication_bloc.dart';

import 'package:app_qldt/enums/config/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'tiles/tiles.dart';

class ScreenPageTilesList extends StatefulWidget {
  const ScreenPageTilesList({Key? key}) : super(key: key);

  @override
  _ScreenPageTilesListState createState() => _ScreenPageTilesListState();
}

class _ScreenPageTilesListState extends State<ScreenPageTilesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 7),
      children: _getSidebarItems(context),
    );
  }

  List<Widget> _getSidebarItems(BuildContext context) {
    final ScreenPage currentScreenPage = _getCurrentScreenPage();
    return _getScreenPagesList(context, currentScreenPage);
  }

  ScreenPage _getCurrentScreenPage() {
    final String? currentRoute = ModalRoute.of(context)!.settings.name;

    for (var value in ScreenPageExtension.displayPagesInSidebar) {
      if (value.string == currentRoute) {
        return value;
      }
    }

    return ScreenPage.login;
  }

  List<Widget> _getScreenPagesList(
      BuildContext context, ScreenPage currentScreenPage) {
    final _firstListItem = currentScreenPage.sidebarIndex == 0
        //
        ? AboveEmptyTile(context)
        : const EmptyTile();

    final _lastListItem = currentScreenPage.sidebarIndex ==
            ScreenPageExtension.displayPagesInSidebar.length - 1
        //
        ? BelowEmptyTile(context)
        : const EmptyTile();

    final List<Widget> _list = [_firstListItem];

    for (int i = 0; i < ScreenPageExtension.displayPagesInSidebar.length; i++) {
      final page = ScreenPageExtension.displayPagesInSidebar[i];
      final isTeacher = context
          .read<AuthenticationBloc>()
          .state
          .user
          .grantedPermissions!
          .contains(11);
      if (page == ScreenPage.score && isTeacher) {
        continue;
      }

      if (page.sidebarIndex == currentScreenPage.sidebarIndex) {
        _list.add(CurrentScreenPageTile(screenPage: page));
      } else if (page.sidebarIndex == currentScreenPage.sidebarIndex - 1) {
        _list.add(AboveScreenPageTile(context, screenPage: page));
      } else if (page.sidebarIndex == currentScreenPage.sidebarIndex + 1) {
        _list.add(BelowScreenPageTile(context, screenPage: page));
      } else {
        _list.add(NormalScreenPageTile(context, screenPage: page));
      }
    }

    _list.add(_lastListItem);

    return _list;
  }
}
