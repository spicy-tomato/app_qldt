import 'package:app_qldt/_models/score_model.dart';
import 'package:app_qldt/_widgets/data_table/data_table.dart';
import 'package:app_qldt/score/bloc/enum/score_type.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:app_qldt/score/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ScorePageTable extends StatefulWidget {
  final ScrollControllers scrollControllers;

  const ScorePageTable({Key? key, required this.scrollControllers}) : super(key: key);

  @override
  _ScorePageTableState createState() => _ScorePageTableState();
}

class _ScorePageTableState extends State<ScorePageTable> {
  static final List<double> _moduleColumnWidths = [70, 70, 70, 70, 90, 130, 100];
  static final List<double> _gpaColumnWidth = [130, 130];

  static final List<String> _moduleColumnTitles = [
    'Điểm quá trình',
    'Điểm thi',
    'Điểm học phần',
    'Điểm chữ',
    'Số tín chỉ',
    'Học kỳ',
    'Trạng thái',
  ];

  static final List<String> _gpaColumnTitles = [
    'GPA10',
    'GPA4',
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
          buildWhen: (previous, current) =>
              previous.scoreData != current.scoreData || previous.scoreType != current.scoreType,
          builder: (context, state) {
            return state.scoreType == ScoreType.moduleScore
                ? MyDataTable(
                    scrollControllers: widget.scrollControllers,
                    columnWidths: _moduleColumnWidths,
                    columnTitles: _moduleColumnTitles,
                    rowTitles: state.scoreData.map((e) => e.moduleName).toList(),
                    data: state.scoreData,
                    legendContent: 'Môn học',
                  )
                : MyDataTable(
                    scrollControllers: widget.scrollControllers,
                    columnTitles: _gpaColumnTitles,
                    columnWidths: _gpaColumnWidth,
                    rowTitles: _gpaData(state.scoreData).map((e) => e.semester).toList(),
                    data: _gpaData(state.scoreData),
                    legendContent: 'Học kỳ',
                  );
          },
        ),
      ),
    );
  }

  List<Gpa> _gpaData(List<ScoreModel> scoreData) {
    Map<String, GpaTotalScore> map = {};
    List<Gpa> gpa = [];

    scoreData.forEach((score) {
      if (score.theoreticalScore != null) {
        if (map[score.semester] == null && score.theoreticalScore != null) {
          map[score.semester] = GpaTotalScore();
        }

        map[score.semester]!.gpa10 += score.theoreticalScore! * score.credit;
        map[score.semester]!.gpa4 += score.theoreticalScore!.toGpa4() * score.credit;
        map[score.semester]!.credit += score.credit;
      }
    });

    map.forEach((key, value) {
      gpa.add(Gpa(
        semester: key,
        gpa10: double.parse((value.gpa10 / value.credit).toStringAsFixed(2)),
        gpa4: double.parse((value.gpa4 / value.credit).toStringAsFixed(2)),
      ));
    });

    return gpa;
  }
}
