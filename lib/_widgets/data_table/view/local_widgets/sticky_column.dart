import 'dart:ui';

import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class StickyColumn extends TableCell {
  StickyColumn(
    String text, {
    required Color backgroundColor,
    required Color horizotalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    required int columnIndex,
    required bool isLastColumn,
    Color? textColor,
  }) : super(
          text,
          cellWidth: cellDimensions.columnWidths![columnIndex],
          cellHeight: cellDimensions.stickyLegendHeight,
          backgroundColor: backgroundColor,
          horizotalBorderColor: horizotalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textMaxLines: 3,
          textColor: textColor,
          isLastColumn: isLastColumn,
          isLastRow: false,
        );
}
