import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'local_widgets/local_widgets.dart';

class MyDataTable extends StatelessWidget {
  final ScrollControllers scrollControllers;
  final CellDimensions _cellDimensions;
  final List data;
  final List<String> columnTitles;

  MyDataTable({
    Key? key,
    required this.scrollControllers,
    required this.columnTitles,
    required List<double> columnWidths,
    required this.data,
    double contentCellHeight = 50,
    double stickyLegendWidth = 130,
    double stickyLegendHeight = 90,
  })  : _cellDimensions = CellDimensions.variableColumnWidth(
          columnWidths: columnWidths,
          contentCellHeight: contentCellHeight,
          stickyLegendWidth: stickyLegendWidth,
          stickyLegendHeight: stickyLegendHeight,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StickyHeadersTable(
      scrollControllers: scrollControllers,
      cellDimensions: _cellDimensions,
      columnsLength: columnTitles.length,
      rowsLength: data.length,
      columnsTitleBuilder: (i) => StickyColumn(
        columnTitles[i],
        columnIndex: i,
        isLastColumn: i == columnTitles.length - 1,
        cellDimensions: _cellDimensions,
        backgroundColor: Theme.of(context).backgroundColor,
        textColor: Colors.white,
        verticalBorderColor: Colors.white,
        horizotalBorderColor: Colors.white,
      ),
      rowsTitleBuilder: (i) => StickyRow(
        data[i].moduleName,
        cellDimensions: _cellDimensions,
        isLastRow: i == data.length - 1,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        verticalBorderColor: Colors.white,
        horizotalBorderColor: Colors.white,
      ),
      contentCellBuilder: (i, j) => ContentCell(
        data[j].toList()[i].toString(),
        columnIndex: i,
        isLastColumn: i == columnTitles.length - 1,
        isLastRow: j == data.length - 1,
        cellDimensions: _cellDimensions,
        textColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        verticalBorderColor: Theme.of(context).primaryColor,
        horizotalBorderColor: Theme.of(context).primaryColor,
      ),
      legendCell: LegendCell(
        'Môn học',
        cellDimensions: _cellDimensions,
        backgroundColor: Theme.of(context).backgroundColor,
        horizotalBorderColor: Colors.white,
        verticalBorderColor: Colors.white,
      ),
    );
  }
}
