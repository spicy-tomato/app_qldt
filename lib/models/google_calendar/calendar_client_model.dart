import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

const clientId = '227524919974-ogjnrouk4pq2cvsgt7jf19nd0h4fio8a.apps.googleusercontent.com';

class CalendarClientModel {
  static const _scopes = [CalendarApi.calendarScope];

  void insert(title, startTime, endTime) {
    final _clientID = ClientId(clientId, '');
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      final calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => debugPrint('VAL________$value'));

      const String calendarId = 'primary';
      final Event event = Event();

      event.summary = title;

      final EventDateTime start = EventDateTime();
      start.dateTime = startTime;
      start.timeZone = 'GMT+05:00';
      event.start = start;

      final EventDateTime end = EventDateTime();
      end.timeZone = 'GMT+05:00';
      end.dateTime = endTime;
      event.end = end;

      try {
        calendar.events.insert(event, calendarId).then((value) {
          debugPrint('ADDED_________________${value.status}');
          if (value.status == 'confirmed') {
            log('Event added in google calendar');
          } else {
            log('Unable to add event in google calendar');
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  Future<void> prompt(String url) async {
    debugPrint('Please go to the following URL and grant access:');
    debugPrint('  => $url');
    debugPrint('');

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}