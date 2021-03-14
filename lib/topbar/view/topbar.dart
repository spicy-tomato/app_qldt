import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/sidebar/bloc/sidebar_bloc.dart';
import 'package:app_qldt/sidebar/sidebar.dart';

class TopBar extends StatelessWidget {
  final Widget? topRightWidget;

  const TopBar({
    Key? key,
    this.topRightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: BlocBuilder<ScreenBloc, ScreenState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              TopBarItem(
                icon: Icons.menu,
                onTap: () => Scaffold.of(context)..openDrawer(),
                alignment: const Alignment(-0.95, 0),
              ),
              topRightWidget ?? Container(),
            ],
          );
        },
      ),
    );
  }
}

class TopBarItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Alignment alignment;
  final IconData icon;

  const TopBarItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(7.5),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
