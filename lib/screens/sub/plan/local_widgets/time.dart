part of 'local_widgets.dart';

class PlanPageTime extends StatefulWidget {
  const PlanPageTime({Key? key}) : super(key: key);

  @override
  _PlanPageTimeState createState() => _PlanPageTimeState();
}

class _PlanPageTimeState extends State<PlanPageTime> {
  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Column(
      children: <Widget>[
        SwitcherTile(themeData),
        FromDatePicker(themeData),
        ToDatePicker(themeData),
        const Repeat(),
      ],
    );
  }
}

//#region SwitcherTile

class SwitcherTile extends StatefulWidget {
  final AppThemeModel themeData;

  const SwitcherTile(
    this.themeData, {
    Key? key,
  }) : super(key: key);

  @override
  _SwitcherTileState createState() => _SwitcherTileState();
}

class _SwitcherTileState extends State<SwitcherTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      buildWhen: (previous, current) => previous.isAllDay != current.isAllDay,
      builder: (context, state) {
        return CustomListTile(
          leading: const Icon(Icons.access_time_rounded),
          title: const Text('Cả ngày'),
          trailing: Theme(
            data: ThemeData(primaryColor: widget.themeData.primaryColor),
            child: Switch(
              activeColor: widget.themeData.primaryColor,
              value: state.isAllDay,
              onChanged: (_) => context.read<PlanBloc>().add(PlanIsAllDayChanged()),
            ),
          ),
          onTap: () => context.read<PlanBloc>().add(PlanIsAllDayChanged()),
        );
      },
    );
  }
}

//#endregion

//#region DatePicker

extension DateTimeExtesion on DateTime {
  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool isSameTime(DateTime other) => isSameDay(other) && hour == other.hour && minute == other.minute;
}

class FromDatePicker extends StatefulWidget {
  final AppThemeModel themeData;

  const FromDatePicker(
    this.themeData, {
    Key? key,
  }) : super(key: key);

  @override
  _FromDatePickerState createState() => _FromDatePickerState();
}

class _FromDatePickerState extends State<FromDatePicker> {
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<PlanBloc, PlanState>(
          buildWhen: (previous, current) => !previous.fromDay.isSameDay(current.fromDay),
          builder: (context, state) {
            return TextButton(
              style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0))),
              onPressed: () => _chooseDay(context, state),
              child: Text(
                DateFormat('E, d MMMM, y', Localizations.localeOf(context).languageCode).format(state.fromDay),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: BlocBuilder<PlanBloc, PlanState>(
          buildWhen: (previous, current) => !previous.fromDay.isSameTime(current.fromDay),
          builder: (context, state) {
            return TextButton(
              onPressed: () => _chooseTime(context, state),
              child: Text(
                DateFormat.Hm().format(state.fromDay),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _chooseDay(BuildContext context, PlanState state) async {
    DateTime? newDate = await showRoundedDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: state.fromDay,
      height: 300,
      theme: ThemeData(
        primaryColor: widget.themeData.primaryColor,
        accentColor: widget.themeData.secondaryColor,
        textTheme: TextTheme(
          caption: TextStyle(color: widget.themeData.secondaryColor),
          bodyText2: TextStyle(color: widget.themeData.primaryColor),
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingMonthHeader: const EdgeInsets.all(13),
        textStyleMonthYearHeader: TextStyle(color: widget.themeData.secondaryTextColor),
        colorArrowPrevious: widget.themeData.secondaryTextColor,
        colorArrowNext: widget.themeData.secondaryTextColor,
        textStyleButtonPositive: TextStyle(color: widget.themeData.secondaryTextColor),
        textStyleButtonNegative: TextStyle(color: widget.themeData.secondaryTextColor),
      ),
    );

    if (newDate != null) {
      newDate = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        state.fromDay.hour,
        state.fromDay.minute,
      );

      context.read<PlanBloc>().add(PlanFromDateChanged(newDate));
    }
  }

  _chooseTime(BuildContext context, PlanState state) async {
    TimeOfDay? newTime = await showRoundedTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(state.fromDay),
      theme: ThemeData(
        primaryColor: widget.themeData.primaryColor,
        accentColor: widget.themeData.secondaryColor,
        textTheme: TextTheme(
          caption: TextStyle(color: widget.themeData.secondaryColor),
          bodyText2: TextStyle(color: widget.themeData.primaryColor),
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingMonthHeader: const EdgeInsets.all(13),
        textStyleMonthYearHeader: TextStyle(color: widget.themeData.secondaryTextColor),
        colorArrowPrevious: widget.themeData.secondaryTextColor,
        colorArrowNext: widget.themeData.secondaryTextColor,
        textStyleButtonPositive: TextStyle(color: widget.themeData.secondaryTextColor),
        textStyleButtonNegative: TextStyle(color: widget.themeData.secondaryTextColor),
      ),
    );

    if (newTime != null) {
      DateTime newDate = DateTime(
        state.fromDay.year,
        state.fromDay.month,
        state.fromDay.day,
        newTime.hour,
        newTime.minute,
      );

      context.read<PlanBloc>().add(PlanFromDateChanged(newDate));
    }
  }
}

class ToDatePicker extends StatefulWidget {
  final AppThemeModel themeData;

  const ToDatePicker(
    this.themeData, {
    Key? key,
  }) : super(key: key);

  @override
  _ToDatePickerState createState() => _ToDatePickerState();
}

class _ToDatePickerState extends State<ToDatePicker> {
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<PlanBloc, PlanState>(
          buildWhen: (previous, current) => !previous.toDay.isSameDay(current.toDay),
          builder: (context, state) {
            return TextButton(
              style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0))),
              onPressed: () => _chooseDay(context, state),
              child: Text(
                DateFormat('E, d MMMM, y', Localizations.localeOf(context).languageCode).format(state.toDay),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: BlocBuilder<PlanBloc, PlanState>(
          buildWhen: (previous, current) => !previous.toDay.isSameTime(current.toDay),
          builder: (context, state) {
            return TextButton(
              onPressed: () => _chooseTime(context, state),
              child: Text(
                DateFormat.Hm().format(state.toDay),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _chooseDay(BuildContext context, PlanState state) async {
    DateTime? newDate = await showRoundedDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: state.toDay,
      height: 300,
      theme: ThemeData(
        primaryColor: widget.themeData.primaryColor,
        accentColor: widget.themeData.secondaryColor,
        textTheme: TextTheme(
          caption: TextStyle(color: widget.themeData.secondaryColor),
          bodyText2: TextStyle(color: widget.themeData.primaryColor),
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingMonthHeader: const EdgeInsets.all(13),
        textStyleMonthYearHeader: TextStyle(color: widget.themeData.secondaryTextColor),
        colorArrowPrevious: widget.themeData.secondaryTextColor,
        colorArrowNext: widget.themeData.secondaryTextColor,
        textStyleButtonPositive: TextStyle(color: widget.themeData.secondaryTextColor),
        textStyleButtonNegative: TextStyle(color: widget.themeData.secondaryTextColor),
      ),
    );

    if (newDate != null) {
      newDate = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        state.toDay.hour,
        state.toDay.minute,
      );

      context.read<PlanBloc>().add(PlanToDateChanged(newDate));
    }
  }

  _chooseTime(BuildContext context, PlanState state) async {
    TimeOfDay? newTime = await showRoundedTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(state.fromDay),
      theme: ThemeData(
        primaryColor: widget.themeData.primaryColor,
        accentColor: widget.themeData.secondaryColor,
        textTheme: TextTheme(
          caption: TextStyle(color: widget.themeData.secondaryColor),
          bodyText2: TextStyle(color: widget.themeData.primaryColor),
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingMonthHeader: const EdgeInsets.all(13),
        textStyleMonthYearHeader: TextStyle(color: widget.themeData.secondaryTextColor),
        colorArrowPrevious: widget.themeData.secondaryTextColor,
        colorArrowNext: widget.themeData.secondaryTextColor,
        textStyleButtonPositive: TextStyle(color: widget.themeData.secondaryTextColor),
        textStyleButtonNegative: TextStyle(color: widget.themeData.secondaryTextColor),
      ),
    );

    if (newTime != null) {
      DateTime newDate = DateTime(
        state.toDay.year,
        state.toDay.month,
        state.toDay.day,
        newTime.hour,
        newTime.minute,
      );

      context.read<PlanBloc>().add(PlanToDateChanged(newDate));
    }
  }
}

//#endregion

//#region Repeat

class Repeat extends StatefulWidget {
  const Repeat({Key? key}) : super(key: key);

  @override
  _RepeatState createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {
  static final List<PlanRepeat> _listItem = PlanRepeat.values.toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      buildWhen: (previous, current) => previous.repeat != current.repeat,
      builder: (context, state) {
        return CustomListTile(
          leading: const Icon(Icons.refresh),
          title: Text(state.repeat.string),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: listRadioItem(state),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  List<Widget> listRadioItem(PlanState state) {
    List<Widget> widgets = [];

    for (int i = 0; i < _listItem.length; i++) {
      widgets.add(InkWell(
        onTap: () => _onTap(_listItem[i]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: <Widget>[
              Radio<PlanRepeat>(
                value: _listItem[i],
                groupValue: state.repeat,
                onChanged: (planRepeat) => _onTap(planRepeat),
              ),
              const SizedBox(width: 5),
              Text(_listItem[i].string)
            ],
          ),
        ),
      ));
    }

    return widgets;
  }

  void _onTap(PlanRepeat? planRepeat) {
    if (planRepeat != null) {
      context.read<PlanBloc>().add(PlanRepeatChanged(planRepeat));
    }

    Navigator.of(context).pop();
  }
}

//#endregion
