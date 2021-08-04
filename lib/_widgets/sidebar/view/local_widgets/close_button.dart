import 'package:flutter/material.dart';

class CloseSidebarButton extends StatelessWidget {
  const CloseSidebarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: Material(
        shape: const CircleBorder(),
        color: Colors.white,
        child: InkWell(
          customBorder: const CircleBorder(),
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
