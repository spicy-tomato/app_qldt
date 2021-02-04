import 'package:flutter/cupertino.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final Function onPressed;

  const TopBar({Key key, @required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Const.topBarBorderRadius,
        color: Const.topBarBackgroundColor,
      ),
      height: MediaQuery.of(context).size.height * Const.topBarHeightRatio,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.1),
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Const.topBarFontSize,
                  color: Const.topBarTextColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-1, -0.2),
            child: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: Const.topBarIconSize,
                  color: Const.topBarTextColor,
                ),
                onPressed: onPressed,),
          )
        ],
      ),
    );
  }
}
