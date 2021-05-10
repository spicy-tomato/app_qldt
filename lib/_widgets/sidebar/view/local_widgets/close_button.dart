import 'package:flutter/material.dart';

class CloseSidebarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      child: Material(
        shape: CircleBorder(),
        color: Colors.white,
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () async => await Navigator.maybePop(context),
          child: Icon(
            Icons.close,
            color: Theme.of(context).backgroundColor,
            size: 25,
          ),
        ),
      ),
    );
  }
}
