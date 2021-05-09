import 'package:flutter/material.dart';

class TableCell extends StatelessWidget {
  final String text;
  final Color? textColor;
  final int? textMaxLines;

  final Color backgroundColor;
  final double cellWidth;
  final double cellHeight;

  final Color horizotalBorderColor;
  final Color verticalBorderColor;
  final bool isLastColumn;
  final bool isLastRow;

  TableCell(
    this.text, {
    required this.cellWidth,
    required this.cellHeight,
    required this.backgroundColor,
    required this.horizotalBorderColor,
    required this.verticalBorderColor,
    required this.isLastColumn,
    required this.isLastRow,
    this.textColor,
    this.textMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cellWidth,
      height: cellHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 15,
        ),
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: textMaxLines ?? 2,
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          right: isLastColumn
              ? BorderSide.none
              : BorderSide(
                  width: 1,
                  color: verticalBorderColor,
                ),
          bottom: isLastRow
              ? BorderSide.none
              : BorderSide(
                  width: 1,
                  color: horizotalBorderColor,
                ),
        ),
      ),
    );
  }
}
