import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'table_cell/table_cell.dart';

class ScoreTable extends StatefulWidget {
  final ScrollControllers scrollControllers;

  const ScoreTable({Key? key, required this.scrollControllers}) : super(key: key);

  @override
  _ScoreTableState createState() => _ScoreTableState();
}

class _ScoreTableState extends State<ScoreTable> {
  static final List<double> columnWidth = [70, 70, 70, 90, 130, 100];

  static final List<String> columnTitle = [
    'Điểm quá trình',
    'Điểm thi',
    'Điểm học phần',
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
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
          ),
        ),
        child: BlocBuilder<ScoreBloc, ScoreState>(
          buildWhen: (previous, current) => previous.scoreData != current.scoreData,
          builder: (context, state) {
            print('Rebuild');
            print(state.scoreData);

            return StickyHeadersTable(
              scrollControllers: widget.scrollControllers,
              cellDimensions: _cellDimensions,
              columnsLength: columnTitle.length,
              rowsLength: state.scoreData.length,
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
                state.scoreData[i].moduleName,
                cellDimensions: _cellDimensions,
                isLastRow: i == state.scoreData.length - 1,
                textColor: Colors.white,
                backgroundColor: Colors.red,
                verticalBorderColor: Colors.white,
                horizotalBorderColor: Colors.white,
              ),
              contentCellBuilder: (i, j) => ContentCell(
                state.scoreData[j].toList()[i].toString(),
                columnIndex: i,
                isLastColumn: i == 5,
                isLastRow: j == state.scoreData.length - 1,
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
          },
        ),
      ),
    );
  }
}
