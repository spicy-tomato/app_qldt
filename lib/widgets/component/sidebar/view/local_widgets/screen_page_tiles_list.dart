import 'package:app_qldt/blocs/authentication/authentication_bloc.dart';
import 'package:app_qldt/enums/config/role.enum.dart';

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
    final isTeacher = context
        .read<AuthenticationBloc>()
        .state
        .user
        .grantedPermissions!
        .contains(11);
    final Role role =  isTeacher ? Role.teacher: Role.student;
    final ScreenPage currentScreenPage = _getCurrentScreenPage(role);
    return _getScreenPagesList(context, currentScreenPage, role);
  }

  ScreenPage _getCurrentScreenPage(Role role) {
    final String? currentRoute = ModalRoute.of(context)!.settings.name;

    for (var value in ScreenPageExtension.displayPagesInSidebar(role)) {
      if (value.string == currentRoute) {
        return value;
      }
    }

    return ScreenPage.login;
  }

  List<Widget> _getScreenPagesList(
      BuildContext context, ScreenPage currentScreenPage, Role role) {
    final _firstListItem = currentScreenPage.sidebarIndex(role) == 0
        //
        ? AboveEmptyTile(context)
        : const EmptyTile();

    final _lastListItem = currentScreenPage.sidebarIndex(role) ==
            ScreenPageExtension.displayPagesInSidebar(role).length - 1
        //
        ? BelowEmptyTile(context)
        : const EmptyTile();

    final List<Widget> _list = [_firstListItem];

    for (int i = 0; i < ScreenPageExtension.displayPagesInSidebar(role).length; i++) {
      final page = ScreenPageExtension.displayPagesInSidebar(role)[i];

      if (page.sidebarIndex(role) == currentScreenPage.sidebarIndex(role)) {
        _list.add(CurrentScreenPageTile(screenPage: page));
      } else if (page.sidebarIndex(role) == currentScreenPage.sidebarIndex(role) - 1) {
        _list.add(AboveScreenPageTile(context, screenPage: page));
      } else if (page.sidebarIndex(role) == currentScreenPage.sidebarIndex(role) + 1) {
        _list.add(BelowScreenPageTile(context, screenPage: page));
      } else {
        _list.add(NormalScreenPageTile(context, screenPage: page));
      }
    }

    _list.add(_lastListItem);

    return _list;
  }
}
