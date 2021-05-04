import 'package:flutter/material.dart';

class PlanPageCustomListTile extends StatefulWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final Function? onTap;

  const PlanPageCustomListTile({
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  }) : super();

  @override
  _PlanPageCustomListTileState createState() => _PlanPageCustomListTileState();
}

class _PlanPageCustomListTileState extends State<PlanPageCustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                widget.leading ?? SizedBox(width: 25, height: 25),
                SizedBox(width: 16),
                Expanded(child: widget.title),
              ],
            ),
          ),
          widget.trailing ?? Container(),
        ],
      ),
    );
  }
}
