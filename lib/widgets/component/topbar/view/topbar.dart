import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/widgets/component/unstable_button/unstable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatefulWidget {
  final Widget? topRightWidget;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool? stable;
  final Function()? beforeOpenSidebar;

  const TopBar({
    Key? key,
    this.topRightWidget,
    this.backgroundColor,
    this.iconColor,
    this.stable,
    this.beforeOpenSidebar,
  }) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.transparent,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopBarItem(
              icon: Icons.menu,
              onTap: _onTap,
            ),
            Row(
              children: <Widget>[
                if (widget.stable!) Container() else UnstableButton(),
                widget.topRightWidget ?? Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (widget.beforeOpenSidebar != null) {
      widget.beforeOpenSidebar!.call();
    }

    Scaffold.of(context).openDrawer();
  }
}

class TopBarItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final Widget? child;

  const TopBarItem({
    Key? key,
    required this.onTap,
    required this.icon,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(7.5),
          child: Icon(
            icon,
            size: 30,
            color: themeData.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
