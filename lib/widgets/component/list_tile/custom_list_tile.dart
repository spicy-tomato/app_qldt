import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final bool? defaultHeight;
  final Function()? onTap;
  final bool? disabled;

  const CustomListTile({
    Key? key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.defaultHeight,
    this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget listTile = Container(
      color: disabled != null && disabled! ? Colors.grey.withOpacity(0.5) : null,
      height: defaultHeight == null || defaultHeight == true ? 48 : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  leading ?? const SizedBox(width: 25, height: 25),
                  const SizedBox(width: 16),
                  Expanded(child: title),
                ],
              ),
            ),
            trailing ?? Container(),
          ],
        ),
      ),
    );

    if (disabled != null && disabled!) {
      return AbsorbPointer(
        child: listTile,
      );
    }

    if (onTap == null) {
      return listTile;
    }

    return Material(
      child: InkWell(
        onTap: onTap,
        child: listTile,
      ),
    );
  }
}
