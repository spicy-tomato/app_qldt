import 'package:flutter/material.dart';
import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class StickyColumn extends AppTableCell {
  StickyColumn(
    String text, {
    Key? key,
    required Color backgroundColor,
    required Color horizontalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    required int columnIndex,
    required bool isLastColumn,
    Color? textColor,
  }) : super(
          text,
          key: key,
          cellWidth: cellDimensions.columnWidths![columnIndex],
          cellHeight: cellDimensions.stickyLegendHeight,
          backgroundColor: backgroundColor,
          horizontalBorderColor: horizontalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textMaxLines: 3,
          textColor: textColor,
          isLastColumn: isLastColumn,
          isLastRow: false,
        );
}
