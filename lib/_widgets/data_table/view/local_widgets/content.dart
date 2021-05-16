import 'dart:ui';

import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class ContentCell extends TableCell {
  ContentCell(
    String text, {
    required Color backgroundColor,
    required Color horizotalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    required columnIndex,
    required bool isLastColumn,
    required bool isLastRow,
    Color? textColor,
  }) : super(
          text,
          cellWidth: cellDimensions.columnWidths![columnIndex],
          cellHeight: cellDimensions.contentCellHeight!,
          backgroundColor: backgroundColor,
          horizotalBorderColor: horizotalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textColor: textColor,
          isLastColumn: isLastColumn,
          isLastRow: isLastRow,
        );
}
