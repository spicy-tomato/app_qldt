import 'package:flutter/material.dart';
import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class StickyRow extends AppTableCell {
  StickyRow(
    String text, {
    Key? key,
    required Color backgroundColor,
    required Color horizontalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    required bool isLastRow,
    Color? textColor,
  }) : super(
          text,
          key: key,
          cellWidth: cellDimensions.stickyLegendWidth,
          cellHeight: cellDimensions.contentCellHeight!,
          backgroundColor: backgroundColor,
          horizontalBorderColor: horizontalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textColor: textColor,
          isLastColumn: false,
          isLastRow: isLastRow,
        );
}
