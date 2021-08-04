import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'local_widgets/local_widgets.dart';

class MyDataTable extends StatelessWidget {
  final ScrollControllers scrollControllers;
  final CellDimensions _cellDimensions;
  final List data;
  final List dataRow;
  final List<String> columnTitles;
  final List<String> rowTitles;
  final String legendContent;

  MyDataTable({
    Key? key,
    required this.scrollControllers,
    required this.columnTitles,
    required this.rowTitles,
    required List<double> columnWidths,
    required this.data,
    required this.legendContent,
    double contentCellHeight = 50,
    double stickyLegendWidth = 130,
    double stickyLegendHeight = 90,
  })  : _cellDimensions = CellDimensions.variableColumnWidth(
          columnWidths: columnWidths,
          contentCellHeight: contentCellHeight,
          stickyLegendWidth: stickyLegendWidth,
          stickyLegendHeight: stickyLegendHeight,
        ),
        dataRow = data.map((item) => item.toList()).toList(),
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
        horizontalBorderColor: Colors.white,
      ),
      rowsTitleBuilder: (i) => StickyRow(
        // data[i].moduleName,
        rowTitles[i],
        cellDimensions: _cellDimensions,
        isLastRow: i == data.length - 1,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        verticalBorderColor: Colors.white,
        horizontalBorderColor: Colors.white,
      ),
      contentCellBuilder: (i, j) => ContentCell(
        dataRow[j][i] == null ? '' : dataRow[j][i].toString(),
        columnIndex: i,
        isLastColumn: i == columnTitles.length - 1,
        isLastRow: j == data.length - 1,
        cellDimensions: _cellDimensions,
        textColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        verticalBorderColor: Theme.of(context).primaryColor,
        horizontalBorderColor: Theme.of(context).primaryColor,
      ),
      legendCell: LegendCell(
        legendContent,
        cellDimensions: _cellDimensions,
        backgroundColor: Theme.of(context).backgroundColor,
        horizontalBorderColor: Colors.white,
        verticalBorderColor: Colors.white,
      ),
    );
  }
}
