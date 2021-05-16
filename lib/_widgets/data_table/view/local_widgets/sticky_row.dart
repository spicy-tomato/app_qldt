import 'dart:ui';

import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class StickyRow extends TableCell {
  StickyRow(
    String text, {
    required Color backgroundColor,
    required Color horizotalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    required bool isLastRow,
    Color? textColor,
  }) : super(
          text,
          cellWidth: cellDimensions.stickyLegendWidth,
          cellHeight: cellDimensions.contentCellHeight!,
          backgroundColor: backgroundColor,
          horizotalBorderColor: horizotalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textColor: textColor,
          isLastColumn: false,
          isLastRow: isLastRow,
        );
}
