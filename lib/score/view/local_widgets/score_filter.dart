import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_widgets/radio_dialog/radio_dialog.dart';
import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/score/bloc/enum/score_type.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:app_qldt/_models/semester_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreFilter extends StatelessWidget {
  const ScoreFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.status.isLoading,
          child: ExpansionTile(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            maintainState: true,
            title: const Text(
              'Thông tin',
              textAlign: TextAlign.center,
            ),
            children: const <Widget>[
              SemesterFilter(),
              StatusFilter(),
              TypeFilter(),
            ],
          ),
        );
      },
    );
  }
}

class _CommonListTile extends CustomListTile {
  _CommonListTile({
    Key? key,
    required Widget title,
    Function()? onTap,
  }) : super(
          key: key,
          title: title,
          onTap: onTap,
          leading: Container(),
        );
}

class SemesterFilter extends StatefulWidget {
  const SemesterFilter({Key? key}) : super(key: key);

  @override
  _SemesterFilterState createState() => _SemesterFilterState();
}

class _SemesterFilterState extends State<SemesterFilter> {
  @override
  Widget build(BuildContext context) {
    final List<SemesterModel> semesterList =
        context.read<UserRepository>().userDataModel.scoreServiceController.semester;

    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) =>
          previous.semester != current.semester || previous.scoreType != current.scoreType,
      builder: (context, state) {
        return state.scoreType == ScoreType.gpaScore
            ? Container()
            : _CommonListTile(
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
    );
  }

  void _onSelect(SemesterModel semester) {
    context.read<ScoreBloc>().add(ScoreSemesterChanged(semester));
    Navigator.of(context).pop();
  }
}

class StatusFilter extends StatefulWidget {
  const StatusFilter({Key? key}) : super(key: key);

  @override
  _StatusFilterState createState() => _StatusFilterState();
}

class _StatusFilterState extends State<StatusFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) =>
          previous.subjectEvaluation != current.subjectEvaluation || previous.scoreType != current.scoreType,
      builder: (context, state) {
        return state.scoreType == ScoreType.gpaScore
            ? Container()
            : _CommonListTile(
                title: Text(
                  'Trạng thái: ' + state.subjectEvaluation.string,
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return RadioAlertDialog<SubjectEvaluation>(
                        title: const Text(
                          'Chọn trạng thái',
                          style: TextStyle(color: Colors.black),
                        ),
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
    context.read<ScoreBloc>().add(ScoreSubjectStatusChanged(subjectEvaluation));
    Navigator.of(context).pop();
  }
}

class TypeFilter extends StatefulWidget {
  const TypeFilter({Key? key}) : super(key: key);

  @override
  _TypeFilterState createState() => _TypeFilterState();
}

class _TypeFilterState extends State<TypeFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) => previous.scoreType != current.scoreType,
      builder: (context, state) {
        return _CommonListTile(
          title: Text(
            'Loại điểm: ' + state.scoreType.string,
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return RadioAlertDialog<ScoreType>(
                  title: const Text(
                    'Chọn loại điểm',
                    style: TextStyle(color: Colors.black),
                  ),
                  onSelect: _onSelect,
                  stringFunction: ScoreTypeExtension.stringFunction,
                  currentOption: state.scoreType,
                  optionsList: ScoreType.values,
                );
              },
            );
          },
        );
      },
    );
  }

  void _onSelect(ScoreType scoreType) {
    context.read<ScoreBloc>().add(ScoreTypeChanged(scoreType));
    Navigator.of(context).pop();
  }
}
