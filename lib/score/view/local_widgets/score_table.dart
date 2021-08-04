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
    'Hệ điểm 10',
    'Hệ điểm 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
          ),
        ),
        child: BlocBuilder<ScoreBloc, ScoreState>(
          buildWhen: (previous, current) =>
              previous.scoreData != current.scoreData || previous.scoreType != current.scoreType,
          builder: (context, state) {
            return state.scoreType.isModuleScore
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
    Map<String, bool> displaySemester = {};
    List<Gpa> gpa = [];

    for (var score in scoreData) {
      if (score.theoreticalScore != null) {
        if (map[score.semester] == null) {
          map[score.semester] = GpaTotalScore();
          displaySemester[score.semester] = true;
        }

        if (displaySemester[score.semester]!) {
          map[score.semester]!.gpa10 += score.theoreticalScore! * score.credit;
          map[score.semester]!.gpa4 += score.theoreticalScore!.toGpa4() * score.credit;
          map[score.semester]!.credit += score.credit;
        }
      } else {
        displaySemester[score.semester] = false;
      }
    }

    map.forEach((semester, value) {
      gpa.add(Gpa(
        semester: semester,
        gpa10:
            displaySemester[semester]! ? double.parse((value.gpa10 / value.credit).toStringAsFixed(2)) : null,
        gpa4:
            displaySemester[semester]! ? double.parse((value.gpa4 / value.credit).toStringAsFixed(2)) : null,
      ));
    });

    return gpa;
  }
}
