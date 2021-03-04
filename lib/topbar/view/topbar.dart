import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/models/screen.dart';
import 'package:app_qldt/sidebar/bloc/sidebar_bloc.dart';
import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/utils/const.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Const.topBarBorderRadius,
        color: Const.topBarBackgroundColor,
      ),
      height: MediaQuery.of(context).size.height * Const.topBarHeightRatio,
      child: BlocBuilder<SidebarBloc, SidebarState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: const Alignment(0, -0.1),
                child: Container(
                  child: Text(
                    state.screenPage.string,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Const.topBarFontSize,
                      color: Const.topBarTextColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(-1, -0.2),
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: Const.topBarIconSize,
                    color: Const.topBarTextColor,
                  ),
                  onPressed: () {
                    // context.read<SidebarBloc>().add(SidebarOpenRequested());
                    Scaffold.of(context)..openDrawer();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
