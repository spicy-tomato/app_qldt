import 'package:flutter/material.dart';
import 'package:table_sticky_headers/cell_dimensions.dart';

import 'cell.dart';

class LegendCell extends AppTableCell {
  LegendCell(
    String text, {
    Key? key,
    required Color backgroundColor,
    required Color horizontalBorderColor,
    required Color verticalBorderColor,
    required CellDimensions cellDimensions,
    Color? textColor,
  }) : super(
          text,
          key: key,
          cellWidth: cellDimensions.stickyLegendWidth,
          cellHeight: cellDimensions.stickyLegendHeight,
          backgroundColor: backgroundColor,
          horizontalBorderColor: horizontalBorderColor,
          verticalBorderColor: verticalBorderColor,
          textColor: textColor,
          isLastRow: false,
        );
}
