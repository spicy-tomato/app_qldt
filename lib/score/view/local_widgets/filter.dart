import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/_widgets/radio_dialog/radio_dialog.dart';
import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:app_qldt/score/model/semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      maintainState: true,
      title: Text(
        'Thông tin',
        textAlign: TextAlign.center,
      ),
      children: <Widget>[
        SemesterFilter(),
        StatusFilter(),
      ],
    );
  }
}

class SemesterFilter extends StatefulWidget {
  @override
  _SemesterFilterState createState() => _SemesterFilterState();
}

class _SemesterFilterState extends State<SemesterFilter> {
  @override
  Widget build(BuildContext context) {
    late List<Semester> semesterList = UserDataModel.of(context)!.localScoreService.semester;

    return BlocBuilder<ScoreBloc, ScoreState>(
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
                return RadioAlertDialog<Semester>(
                    onSelect: _onSelect,
                    stringFunction: Semester.getString,
                    currentOption: state.semester,
                    optionsList: semesterList);
              },
            );
          },
        );
      },
    );
  }

  void _onSelect(Semester semester) {
    context.read<ScoreBloc>().add(ScoreSemesterChanged(semester, context));
    Navigator.of(context).pop();
  }
}

class StatusFilter extends StatefulWidget {
  @override
  _StatusFilterState createState() => _StatusFilterState();
}

class _StatusFilterState extends State<StatusFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) => previous.subjectEvaluation != current.subjectEvaluation,
      builder: (context, state) {
        return CustomListTile(
          title: Text(
            'Trạng thái: ' + state.subjectEvaluation.string,
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return RadioAlertDialog<SubjectEvaluation>(
                  onSelect: _onSelect,
                  stringFunction: SubjectStatusExtension.stringFunction,
                  currentOption: state.subjectEvaluation,
                  optionsList: SubjectEvaluation.values,
                );
              },
            );
          },
        );
      },
    );
  }

  void _onSelect(SubjectEvaluation subjectEvaluation) {
    context.read<ScoreBloc>().add(ScoreSubjectStatusChanged(subjectEvaluation, context));
    Navigator.of(context).pop();
  }
}
