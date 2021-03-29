import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final Widget? topRightWidget;

  const TopBar({
    Key? key,
    this.topRightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 60,
      child: Stack(
        children: <Widget>[
          TopBarItem(
            icon: Icons.menu,
            onTap: () => Scaffold.of(context)..openDrawer(),
            alignment: const Alignment(-0.95, 0),
          ),
          topRightWidget ?? Container(),
        ],
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
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
