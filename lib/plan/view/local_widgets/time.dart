import 'package:flutter/material.dart';
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
    return CommonPadding(
      child: Column(
        children: <Widget>[
          SwitcherTile(),
          DatePicker(dateTime: from),
          DatePicker(dateTime: to),
          Repeat(),
        ],
      ),
    );
  }
}

//#region Switcher

class SwitcherTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      leading: Icon(Icons.access_time_rounded),
      title: Text('Cả ngày', style: PlanPageConstant.of(context).textFieldStyle),
      trailing: Switcher(),
    );
  }
}

class Switcher extends StatefulWidget {
  final bool? initState;

  Switcher({this.initState});

  @override
  _SwitcherState createState() => _SwitcherState(initState);
}

class _SwitcherState extends State<Switcher> {
  late bool isOn;

  _SwitcherState(bool? isOn) {
    this.isOn = isOn ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isOn,
      onChanged: toggleSwitch,
    );
  }

  void toggleSwitch(_) {
    setState(() {
      isOn = !isOn;
    });
  }
}

//#endregion

//#region DatePicker

class DatePicker extends StatefulWidget {
  final DateTime dateTime;

  const DatePicker({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState(dateTime);
}

class _DatePickerState extends State<DatePicker> {
  DateTime date;
  late TimeOfDay timeOfDay;

  _DatePickerState(this.date) {
    timeOfDay = TimeOfDay.fromDateTime(date);
  }

  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      title: TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            initialDate: date,
          );

          if (newDate != null) {
            setState(() {
              date = newDate;
            });
          }

          return Future.value(false);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              "${DateFormat('E, d MMMM, y', Localizations.localeOf(context).languageCode).format(date)}",
              style: PlanPageConstant.of(context).textFieldStyle),
        ),
      ),
      trailing: TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.only(right: 10))),
        child: Text(
          "${DateFormat.Hm().format(date)}",
          style: PlanPageConstant.of(context).textFieldStyle,
        ),
        onPressed: () async {
          TimeOfDay? newTimeOfDay = await showTimePicker(context: context, initialTime: timeOfDay);

          if (newTimeOfDay != null) {
            setState(() {
              timeOfDay = newTimeOfDay;
            });
          }

          return Future.value(false);
        },
      ),
    );
  }
}

//#endregion

//#region Repeat

class Repeat extends StatefulWidget {
  @override
  _RepeatState createState() => _RepeatState();
}

// ignore: camel_case_types
class _RepeatState extends State<Repeat> {
  late String value = 'Không lặp lại';
  List _listItem = [
    'Không lặp lại',
    'Hàng ngày',
    'Hàng tuần',
    'Hàng tháng',
    'Hàng năm',
    'Tuỳ chỉnh...'
  ];

  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      leading: Icon(Icons.refresh),
      title: CommonPadding(
        child: DropdownButton(
            dropdownColor: Colors.grey,
            style: TextStyle(color: Colors.black, fontSize: 22.0),
            elevation: 5,
            icon: new Icon(Icons.arrow_drop_down),
            iconSize: 36.0,
            isExpanded: true,
            value: value,
            onChanged: (newValue) {
              setState(() {
                value = newValue.toString();
              });
            },
            items: _listItem.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(
                  option,
                  style: PlanPageConstant.of(context).textFieldStyle,
                ),
              );
            }).toList()),
      ),
    );
  }
}

//#endregion
