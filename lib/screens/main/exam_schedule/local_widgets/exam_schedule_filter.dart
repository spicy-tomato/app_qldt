part of 'local_widgets.dart';

class ExamScheduleFilter extends StatefulWidget {
  const ExamScheduleFilter({Key? key}) : super(key: key);

  @override
  _ExamScheduleFilterState createState() => _ExamScheduleFilterState();
}

class _ExamScheduleFilterState extends State<ExamScheduleFilter> {
  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;
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
                  style: TextStyle(
                    color: themeData.secondaryTextColor,
                    fontSize: 17,
                  ),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return RadioAlertDialog<SemesterModel>(
                        title: Text(
                          'Chọn học kỳ',
                          style: TextStyle(color: themeData.secondaryTextColor),
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
