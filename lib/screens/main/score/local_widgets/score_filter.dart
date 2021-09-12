part of 'local_widgets.dart';

class ScoreFilter extends StatefulWidget {
  const ScoreFilter({Key? key}) : super(key: key);

  @override
  _ScoreFilterState createState() => _ScoreFilterState();
}

class _ScoreFilterState extends State<ScoreFilter> {
  late AppThemeModel themeData;

  TextStyle get tileTextStyle => TextStyle(
        fontSize: 16,
        color: themeData.secondaryTextColor,
      );

  @override
  Widget build(BuildContext context) {
    themeData = context.read<AppSettingBloc>().state.theme.data;

    return BlocBuilder<ScoreBloc, ScoreState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.status.isLoading,
          child: ExpansionTile(
            textColor: themeData.secondaryTextColor,
            iconColor: themeData.secondaryTextColor,
            backgroundColor: themeData.primaryTextColor,
            collapsedIconColor: themeData.secondaryTextColor,
            collapsedBackgroundColor: themeData.primaryTextColor,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            maintainState: true,
            title: const Text(
              'Thông tin',
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              SemesterFilter(tileTextStyle),
              StatusFilter(tileTextStyle),
              TypeFilter(tileTextStyle),
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
  final TextStyle textStyle;

  const SemesterFilter(
    this.textStyle, {
    Key? key,
  }) : super(key: key);

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
                  style: widget.textStyle,
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return RadioAlertDialog<SemesterModel>(
                        title: Text(
                          'Chọn học kỳ',
                          style: TextStyle(color: widget.textStyle.color),
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
  final TextStyle textStyle;

  const StatusFilter(
    this.textStyle, {
    Key? key,
  }) : super(key: key);

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
                  style: widget.textStyle,
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return RadioAlertDialog<SubjectEvaluation>(
                        title: Text(
                          'Chọn trạng thái',
                          style: TextStyle(color: widget.textStyle.color),
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
  final TextStyle textStyle;

  const TypeFilter(
    this.textStyle, {
    Key? key,
  }) : super(key: key);

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
            style: widget.textStyle,
          ),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return RadioAlertDialog<ScoreType>(
                  title: Text(
                    'Chọn loại điểm',
                    style: TextStyle(color: widget.textStyle.color),
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
