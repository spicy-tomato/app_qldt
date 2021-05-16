import 'package:app_qldt/_widgets/data_table/data_table.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ScoreTable extends StatefulWidget {
  final ScrollControllers scrollControllers;

  const ScoreTable({Key? key, required this.scrollControllers}) : super(key: key);

  @override
  _ScoreTableState createState() => _ScoreTableState();
}

class _ScoreTableState extends State<ScoreTable> {
  static final List<double> _columnWidths = [70, 70, 70, 90, 130, 100];

  static final List<String> _columnTitles = [
    'Điểm quá trình',
    'Điểm thi',
    'Điểm học phần',
    'Số tín chỉ',
    'Học kỳ',
    'Trạng thái',
  ];

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
            return MyDataTable(
              scrollControllers: widget.scrollControllers,
              columnWidths: _columnWidths,
              columnTitles: _columnTitles,
              data: state.scoreData,
            );
          },
        ),
      ),
    );
  }
}
