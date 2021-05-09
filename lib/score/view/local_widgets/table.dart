import 'package:app_qldt/_models/score.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'table_cell/table_cell.dart';

class ScoreTable extends StatefulWidget {
  final List<Score> scoreData;

  const ScoreTable(this.scoreData, {Key? key}) : super(key: key);

  @override
  _ScoreTableState createState() => _ScoreTableState();
}

class _ScoreTableState extends State<ScoreTable> {
  static final List<double> columnWidth = [70, 70, 70, 90, 130, 100];

  static final List<String> columnTitle = [
    'Điểm thành phần',
    'Điểm thi',
    'Điểm tổng kết',
    'Số tín chỉ',
    'Học kỳ',
    'Trạng thái',
  ];

  static final CellDimensions _cellDimensions = CellDimensions.variableColumnWidth(
    columnWidths: columnWidth,
    contentCellHeight: 50,
    stickyLegendWidth: 130,
    stickyLegendHeight: 90,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white),
        ),
      ),
      child: StickyHeadersTable(
        cellDimensions: _cellDimensions,
        columnsLength: columnTitle.length,
        rowsLength: widget.scoreData.length,
        columnsTitleBuilder: (i) => StickyColumn(
          columnTitle[i],
          columnIndex: i,
          isLastColumn: i == 5,
          cellDimensions: _cellDimensions,
          backgroundColor: Theme.of(context).backgroundColor,
          textColor: Colors.white,
          verticalBorderColor: Colors.white,
          horizotalBorderColor: Colors.white,
        ),
        rowsTitleBuilder: (i) => StickyRow(
          widget.scoreData[i].moduleName,
          cellDimensions: _cellDimensions,
          isLastRow: i == widget.scoreData.length - 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          verticalBorderColor: Colors.white,
          horizotalBorderColor: Colors.white,
        ),
        contentCellBuilder: (i, j) => ContentCell(
          widget.scoreData[j].toList()[i].toString(),
          columnIndex: i,
          isLastColumn: i == 5,
          isLastRow: j == widget.scoreData.length - 1,
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
      ),
    );
  }
}
