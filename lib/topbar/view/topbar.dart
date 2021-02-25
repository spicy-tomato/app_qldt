import 'package:app_qldt/sidebar/bloc/sidebar_bloc.dart';
import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Const.topBarBorderRadius,
        color: Const.topBarBackgroundColor,
      ),
      height: MediaQuery.of(context).size.height * Const.topBarHeightRatio,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.1),
            child: Container(
              child: Text(
                'Top bar',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Const.topBarFontSize,
                  color: Const.topBarTextColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-1, -0.2),
            child: BlocBuilder<SidebarBloc, SidebarState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: Const.topBarIconSize,
                    color: Const.topBarTextColor,
                  ),
                  onPressed: () {
                    context.read<SidebarBloc>().add(SidebarOpenRequested());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
