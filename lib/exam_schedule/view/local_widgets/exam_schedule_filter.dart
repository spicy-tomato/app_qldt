import 'package:app_qldt/_models/semester_model.dart';
import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/_widgets/radio_dialog/radio_dialog.dart';
import 'package:app_qldt/exam_schedule/bloc/exam_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamScheduleFilter extends StatefulWidget {
  @override
  _ExamScheduleFilterState createState() => _ExamScheduleFilterState();
}

class _ExamScheduleFilterState extends State<ExamScheduleFilter> {
  @override
  Widget build(BuildContext context) {
    final List<SemesterModel> semesterList = UserDataModel.of(context).localExamScheduleService.semester;

    return BlocBuilder<ExamScheduleBloc, ExamScheduleState>(
      buildWhen: (previous, current) => previous.semester != current.semester,
      builder: (context, state) {
        return CustomListTile(
          title: Text(
            'Học kỳ: ' + state.semester.toString(),
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return RadioAlertDialog<SemesterModel>(
                    onSelect: _onSelect,
                    stringFunction: SemesterModel.getString,
                    currentOption: state.semester,
                    optionsList: semesterList);
              },
            );
          },
        );
      },
    );
  }

  void _onSelect(SemesterModel semester) {
    context.read<ExamScheduleBloc>().add(ExamScheduleSemesterChanged(semester));
    Navigator.of(context).pop();
  }
}
