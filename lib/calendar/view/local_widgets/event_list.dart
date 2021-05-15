import 'dart:math';
import 'package:app_qldt/calendar/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:app_qldt/_models/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventList extends StatelessWidget {
  final List? event;

  const EventList({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) {
        return current.buildFirstTime &&
            !DeepCollectionEquality().equals(
              previous.selectedEvents,
              current.selectedEvents,
            );
      },
      builder: (_, state) {
        return state.selectedEvents == null || state.selectedEvents!.length == 0
            ? Container(color: Colors.transparent)
            : Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: ScrollConfiguration(
                      behavior: _EventListScrollBehavior(),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: min(state.selectedEvents!.length, 3),
                        separatorBuilder: (_, __) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Color(0xff694A85),
                              indent: 45,
                              endIndent: 45,
                              thickness: 2,
                            ),
                          );
                        },
                        itemBuilder: (_, index) =>
                            _EventListItem(event: state.selectedEvents![index]),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              );
      },
    );
  }
}

class _EventListScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(_, Widget child, __) {
    return child;
  }
}

class _EventListItem extends StatelessWidget {
  final UserEvent event;

  const _EventListItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? minute = event.from?.minute.toString();

    if (minute != null) {
      minute = '0' + minute;
      minute = minute.substring(minute.length - 2);
    }

    String? hour = event.from?.hour.toString();

    return Container(
      child: Row(
        children: <Widget>[
          hour != null && minute != null
              ? Text(
                  hour + ':' + minute,
                  style: TextStyle(
                    color: Color(0xff694A85),
                    fontSize: 25,
                  ),
                )
              : Container(),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    event.visualizeName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff694A85),
                      // ),
                    ),
                  ),
                ),
                Text(
                  event.location ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff694A85),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
