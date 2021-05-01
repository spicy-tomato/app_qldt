import 'package:app_qldt/_models/user_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventInfoPage extends StatefulWidget {
  final UserEvent event;

  const EventInfoPage({Key? key, required this.event}) : super(key: key);

  @override
  _EventInfoPageState createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit_outlined),
                          onPressed: () {
                            print("Edit");
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            print("Option");
                          },
                        ),
                      ],
                    )
                  ],
                ),
                ListTile(
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
                  subtitle: Text('${DateFormat(
                    'EEEE, d MMMM',
                    Localizations.localeOf(context).languageCode,
                  ).format(widget.event.from!)}'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text(widget.event.location.toString()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
