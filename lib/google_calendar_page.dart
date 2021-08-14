import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'models/google_calendar/calendar_client_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalendarClientModel calendarClient = CalendarClientModel();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(days: 1));
  final TextEditingController _eventName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2019, 3, 5),
                        maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                      debugPrint('change $date');
                    }, onConfirm: (date) {
                      setState(() {
                        startTime = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: const Text(
                    'Event Start Time',
                    style: TextStyle(color: Colors.blue),
                  )),
              Text('$startTime'),
            ],
          ),
          Row(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2019, 3, 5),
                        maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                      debugPrint('change $date');
                    }, onConfirm: (date) {
                      setState(() {
                        endTime = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: const Text(
                    'Event End Time',
                    style: TextStyle(color: Colors.blue),
                  )),
              Text('$endTime'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _eventName,
              decoration: const InputDecoration(hintText: 'Enter Event name'),
            ),
          ),
          ElevatedButton(
              child: const Text('Insert Event'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () {
                //log('add event pressed');
                calendarClient.insert(
                  _eventName.text,
                  startTime,
                  endTime,
                );
              }),
        ],
      ),
    );
  }
}
