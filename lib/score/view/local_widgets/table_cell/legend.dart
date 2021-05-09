import 'dart:ui';

import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class LegendCell extends TableCell {
  LegendCell(
    String text, {
    required Color backgroundColor,
    required Color horizotalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    Color? textColor,
  }) : super(
          text,
          cellWidth: cellDimensions.stickyLegendWidth,
          cellHeight: cellDimensions.stickyLegendHeight,
          backgroundColor: backgroundColor,
          horizotalBorderColor: horizotalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textColor: textColor,
          isLastColumn: false,
          isLastRow: false,
        );
}
