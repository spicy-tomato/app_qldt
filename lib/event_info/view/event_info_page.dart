import 'package:app_qldt/_models/user_event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventInfoPage extends StatefulWidget {
  final UserEventModel event;

  const EventInfoPage({Key? key, required this.event}) : super(key: key);

  @override
  _EventInfoPageState createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          /// TODO
                          print("Edit");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          /// TODO
                          print("Option");
                        },
                      ),
                    ],
                  )
                ],
              ),
              ListTile(
                horizontalTitleGap: 4,
                leading: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.event.backgroundColor,
                  ),
                ),
                title: Text(
                  widget.event.visualizeName,
                  style: TextStyle(fontSize: 23),
                  softWrap: true,
                ),
                subtitle: Text(
                  widget.event.from == DateTime(now.year, now.month, now.day)
                      ? 'Hôm nay'
                      : '${DateFormat(
                          'E, d MMMM',
                          Localizations.localeOf(context).languageCode,
                        ).format(widget.event.from!)} · ${DateFormat.Hm().format(widget.event.from!)} - ${DateFormat.Hm().format(widget.event.to!)}',
                ),
              ),
              widget.event.location == null
                  ? Container()
                  : ListTile(
                      horizontalTitleGap: 4,
                      leading: Icon(Icons.location_on_outlined),
                      title: Text(widget.event.location!),
                    ),
              widget.event.note == null
                  ? Container()
                  : ListTile(
                      horizontalTitleGap: 4,
                      leading: Icon(Icons.sticky_note_2_outlined),
                      title: Text(widget.event.note!),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String startTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}';
  }
}
