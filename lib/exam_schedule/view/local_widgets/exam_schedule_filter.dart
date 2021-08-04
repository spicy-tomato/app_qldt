import 'package:app_qldt/_models/semester_model.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/_widgets/radio_dialog/radio_dialog.dart';
import 'package:app_qldt/exam_schedule/bloc/exam_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamScheduleFilter extends StatefulWidget {
  const ExamScheduleFilter({Key? key}) : super(key: key);

  @override
  _ExamScheduleFilterState createState() => _ExamScheduleFilterState();
}

class _ExamScheduleFilterState extends State<ExamScheduleFilter> {
  @override
  Widget build(BuildContext context) {
    final List<SemesterModel> semesterList =
        context.read<UserRepository>().userDataModel.examScheduleServiceController.semester;

    return BlocBuilder<ExamScheduleBloc, ExamScheduleState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.status.isLoading,
          child: BlocBuilder<ExamScheduleBloc, ExamScheduleState>(
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
                        title: const Text(
                          'Chọn học kỳ',
                          style: TextStyle(color: Colors.black),
                        ),
                        onSelect: _onSelect,
                        stringFunction: SemesterModel.getString,
                        currentOption: state.semester,
                        optionsList: semesterList,
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _onSelect(SemesterModel semester) {
    context.read<ExamScheduleBloc>().add(ExamScheduleSemesterChanged(semester));
    Navigator.of(context).pop();
  }
}
