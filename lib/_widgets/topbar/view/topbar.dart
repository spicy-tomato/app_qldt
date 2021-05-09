import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final Widget? topRightWidget;
  final Color? backgroundColor;
  final Color? iconColor;

  const TopBar({
    Key? key,
    this.topRightWidget,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      height: 60,
      child: Stack(
        children: <Widget>[
          TopBarItem(
            icon: Icons.menu,
            color: iconColor,
            alignment: const Alignment(-0.95, 0),
            onTap: () => Scaffold.of(context)..openDrawer(),
          ),
          topRightWidget ?? Container(),
        ],
      ),
    );
  }
}

class TopBarItem extends StatelessWidget {
  final Function() onTap;
  final Alignment alignment;
  final IconData icon;
  final Color? color;

  const TopBarItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.alignment,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
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
      ),
    );
  }
}
