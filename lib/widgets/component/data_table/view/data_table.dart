import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';

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
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return StickyHeadersTable(
      scrollControllers: scrollControllers,
      cellDimensions: _cellDimensions,
      columnsLength: columnTitles.length,
      rowsLength: data.length,
      columnsTitleBuilder: (i) => StickyColumn(
        columnTitles[i],
        columnIndex: i,
        cellDimensions: _cellDimensions,
        backgroundColor: themeData.primaryColor,
        textColor: themeData.primaryTextColor,
        verticalBorderColor: themeData.primaryTextColor,
        horizontalBorderColor: themeData.primaryTextColor,
      ),
      rowsTitleBuilder: (i) => StickyRow(
        rowTitles[i],
        cellDimensions: _cellDimensions,
        isLastRow: i == data.length - 1,
        textColor: themeData.primaryTextColor,
        backgroundColor: themeData.tableCellColor,
        verticalBorderColor: themeData.primaryTextColor,
        horizontalBorderColor: themeData.primaryTextColor,
      ),
      contentCellBuilder: (i, j) => ContentCell(
        dataRow[j][i] == null ? '' : dataRow[j][i].toString(),
        columnIndex: i,
        isLastRow: j == data.length - 1,
        cellDimensions: _cellDimensions,
        textColor: themeData.secondaryTextColor,
        backgroundColor: themeData.primaryTextColor,
        verticalBorderColor: themeData.secondaryTextColor,
        horizontalBorderColor: themeData.secondaryTextColor,
      ),
      legendCell: LegendCell(
        legendContent,
        textColor: themeData.primaryTextColor,
        cellDimensions: _cellDimensions,
        backgroundColor: themeData.primaryColor,
        horizontalBorderColor: themeData.primaryTextColor,
        verticalBorderColor: themeData.primaryTextColor,
      ),
    );
  }
}
