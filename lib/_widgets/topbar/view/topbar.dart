import 'package:app_qldt/_widgets/element/unstable_button.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final Widget? topRightWidget;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool? stable;

  const TopBar({
    Key? key,
    this.topRightWidget,
    this.backgroundColor,
    this.iconColor,
    this.stable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      height: 60,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopBarItem(
              icon: Icons.menu,
              color: iconColor,
              onTap: () => Scaffold.of(context)..openDrawer(),
            ),
            Row(
              children: <Widget>[
                stable! ? Container() : UnstableButton(),
                topRightWidget ?? Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TopBarItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final Color? color;
  final Widget? child;

  const TopBarItem({
    Key? key,
    required this.icon,
    required this.onTap,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(7.5),
            child: Icon(
              icon,
              size: 30,
              color: color ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
