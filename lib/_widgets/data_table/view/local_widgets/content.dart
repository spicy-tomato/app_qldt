import 'package:flutter/material.dart';
import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class ContentCell extends AppTableCell {
  ContentCell(
    String text, {
    Key? key,
    required Color backgroundColor,
    required Color horizontalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    required columnIndex,
    required bool isLastColumn,
    required bool isLastRow,
    Color? textColor,
  }) : super(
          text,
          key: key,
          cellWidth: cellDimensions.columnWidths![columnIndex],
          cellHeight: cellDimensions.contentCellHeight!,
          backgroundColor: backgroundColor,
          horizontalBorderColor: horizontalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textColor: textColor,
          isLastColumn: isLastColumn,
          isLastRow: isLastRow,
        );
}
