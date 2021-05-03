
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'common_padding.dart';

class PlanPageTime extends StatefulWidget {
  @override
  _PlanPageTimeState createState() => _PlanPageTimeState();
}

class _PlanPageTimeState extends State<PlanPageTime> {
  late DateTime pickedDatef;
  late DateTime pickedDatel;
  late TimeOfDay timef;
  late TimeOfDay timel;
  late DateTime from = DateTime.now();
  late DateTime to = from.add(Duration(hours: 3));

  final _textStyle = TextStyle(
    color: Colors.grey[700],
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    pickedDatef = DateTime.now();
    pickedDatel = DateTime.now();
    timef = TimeOfDay.now();
    timel = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomListTile(
            leading: Icon(Icons.access_time_rounded),
            title: Text(
              'Cả ngày',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Switcher(),
          ),
          _row(from),
          _row(to),
        ],
      ),
    );
  }

  Widget _row(DateTime dateTime) {
    return CustomListTile(
      title: TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
        onPressed: () async {
          DateTime datef = (await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            initialDate: pickedDatef,
          ))!;
          setState(() {
            pickedDatef = datef;
          });
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              "${DateFormat('E, d MMMM, y', Localizations.localeOf(context).languageCode).format(dateTime)}",
              style: _textStyle),
        ),
      ),
      trailing: TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.only(right: 10))),
        child: Text(
          "${DateFormat.Hm().format(dateTime)}",
          style: _textStyle,
        ),
        onPressed: () async {
          TimeOfDay timefi = (await showTimePicker(
            context: context,
            initialTime: timef,
          ))!;
          setState(() {
            timef = timefi;
          });
        },
      ),
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

class CustomListTile extends StatefulWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;

  const CustomListTile({
    this.leading,
    required this.title,
    this.trailing,
  }) : super();

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              widget.leading ?? SizedBox(width: 25, height: 25),
              SizedBox(width: 16),
              widget.title,
            ],
          ),
          widget.trailing ?? Container(),
        ],
      ),
    );
  }
}
