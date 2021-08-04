import 'package:app_qldt/_models/screen.dart';
import 'package:flutter/material.dart';

class ScreenPageTile extends StatelessWidget {
  final ScreenPage? screenPage;
  final bool? current;
  final bool? empty;
  final CustomPainter? painter;
  final Function()? onTap;

  final TextStyle tileTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  const ScreenPageTile({
    Key? key,
    this.screenPage,
    this.current,
    this.empty,
    this.painter,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter,
      child: Container(
        decoration: current != null && current!
            ? const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              )
            : null,
        child: empty == null || !empty!
            ? ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    screenPage != null ? screenPage!.name : 'Đăng xuất',
                    style: TextStyle(
                      fontSize: 18,
                      color: current != null && current!
                          ? Theme.of(context).backgroundColor
                          : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: onTap,
              )
            : Container(height: 56),
      ),
    );
  }
}
