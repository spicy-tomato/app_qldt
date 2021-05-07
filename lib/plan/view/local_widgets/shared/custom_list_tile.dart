import 'package:flutter/material.dart';

class PlanPageCustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final bool? defaultHeight;
  final Function()? onTap;

  const PlanPageCustomListTile({
    Key? key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.defaultHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget listTile = Container(
      height: defaultHeight == null || defaultHeight == true ? 48 : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  leading ?? SizedBox(width: 25, height: 25),
                  SizedBox(width: 16),
                  Expanded(child: title),
                ],
              ),
            ),
            trailing ?? Container(),
          ],
        ),
      ),
    );

    if (onTap == null) {
      return listTile;
    }

    return InkWell(
      onTap: onTap,
      child: listTile,
    );
  }
}
