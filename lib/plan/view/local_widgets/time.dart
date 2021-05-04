import 'package:app_qldt/plan/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'shared/shared.dart';

class PlanPageTime extends StatefulWidget {
  @override
  _PlanPageTimeState createState() => _PlanPageTimeState();
}

class _PlanPageTimeState extends State<PlanPageTime> {
  late DateTime from = DateTime.now();
  late DateTime to = from.add(Duration(hours: 3));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitcherTile(),
        FromDatePicker(),
        ToDatePicker(),
        Repeat(),
      ],
    );
  }
}

//#region SwitcherTile

class SwitcherTile extends StatefulWidget {
  _SwitcherTileState createState() => _SwitcherTileState();
}

class _SwitcherTileState extends State<SwitcherTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      buildWhen: (previous, current) => previous.isAllDay != current.isAllDay,
      builder: (context, state) {
        return PlanPageCustomListTile(
          leading: const Icon(Icons.access_time_rounded),
          title: Text('Cả ngày', style: PlanPageConstant.of(context).textFieldStyle),
          trailing: Switch(
            value: state.isAllDay,
            onChanged: (_) => context.read<PlanBloc>().add(PlanIsAllDayChanged()),
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

  bool isSameTime(DateTime other) =>
      this.isSameDay(other) && hour == other.hour && minute == other.minute;
}

class FromDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<PlanBloc, PlanState>(
          buildWhen: (previous, current) => !previous.fromDay.isSameDay(current.fromDay),
          builder: (context, state) {
            return TextButton(
              style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              onPressed: () => _chooseDay(context, state),
              child: Text(
                  "${DateFormat('E, d MMMM, y', Localizations.localeOf(context).languageCode).format(state.fromDay)}",
                  style: PlanPageConstant.of(context).textFieldStyle),
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
                "${DateFormat.Hm().format(state.fromDay)}",
                style: PlanPageConstant.of(context).textFieldStyle,
              ),
            );
          },
        ),
      ),
    );
  }

  final Function _chooseDay = (BuildContext context, PlanState state) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: state.fromDay,
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
  };

  final Function _chooseTime = (BuildContext context, PlanState state) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(state.fromDay),
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
  };
}

class ToDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<PlanBloc, PlanState>(
          buildWhen: (previous, current) => !previous.toDay.isSameDay(current.toDay),
          builder: (context, state) {
            return TextButton(
              style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
              onPressed: () => _chooseDay(context, state),
              child: Text(
                  "${DateFormat('E, d MMMM, y', Localizations.localeOf(context).languageCode).format(state.toDay)}",
                  style: PlanPageConstant.of(context).textFieldStyle),
            );
          },
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 10),
        child: BlocBuilder<PlanBloc, PlanState>(
          buildWhen: (previous, current) => !previous.toDay.isSameTime(current.toDay),
          builder: (context, state) {
            return TextButton(
              onPressed: () => _chooseTime(context, state),
              child: Text(
                "${DateFormat.Hm().format(state.toDay)}",
                style: PlanPageConstant.of(context).textFieldStyle,
              ),
            );
          },
        ),
      ),
    );
  }

  final Function _chooseDay = (BuildContext context, PlanState state) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: state.toDay,
    );

    if (newDate != null) {
      newDate = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        state.toDay.hour,
        state.toDay.minute,
      );

      context.read<PlanBloc>().add(PlanFromDateChanged(newDate));
    }
  };

  final Function _chooseTime = (BuildContext context, PlanState state) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(state.toDay),
    );

    if (newTime != null) {
      DateTime newDate = DateTime(
        state.toDay.year,
        state.toDay.month,
        state.toDay.day,
        newTime.hour,
        newTime.minute,
      );

      context.read<PlanBloc>().add(PlanFromDateChanged(newDate));
    }
  };
}

//#endregion

//#region Repeat

class Repeat extends StatefulWidget {
  const Repeat({Key? key}) : super(key: key);

  @override
  _RepeatState createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {
  static List<PlanRepeat> _listItem = PlanRepeat.values.toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      buildWhen: (previous, current) => previous.repeat != current.repeat,
      builder: (context, state) {
        return PlanPageCustomListTile(
          leading: Icon(Icons.refresh),
          title: Text(
            state.repeat.string,
            style: PlanPageConstant.of(context).textFieldStyle,
          ),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: <Widget>[
              Radio<PlanRepeat>(
                value: _listItem[i],
                groupValue: state.repeat,
                onChanged: (planRepeat) => _onTap(planRepeat),
              ),
              SizedBox(width: 5),
              Text(
                _listItem[i].string,
                style: PlanPageConstant.of(context).textFieldStyle,
              )
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
