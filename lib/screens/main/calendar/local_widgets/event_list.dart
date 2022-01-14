import 'dart:math';

import 'package:app_qldt/blocs/calendar/calendar_bloc.dart';
import 'package:app_qldt/models/event/user_event_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
            !const DeepCollectionEquality().equals(
              previous.selectedEvents,
              current.selectedEvents,
            );
      },
      builder: (_, state) {
        return state.selectedEvents == null || state.selectedEvents!.isEmpty
            ? Container()
            : Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Divider(
                              color: Color(0xff694A85),
                              indent: 45,
                              endIndent: 45,
                              thickness: 2,
                            ),
                          );
                        },
                        itemBuilder: (_, index) => _EventListItem(event: state.selectedEvents![index]),
                      ),
                    ),
                  ),
                  const Spacer(),
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
  final UserEventModel event;

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

    final String? hour = event.from?.hour.toString();

    return Row(
      children: <Widget>[
        if (hour != null && minute != null)
          Text(
            hour + ':' + minute,
            style: const TextStyle(
              color: Color(0xff694A85),
              fontSize: 25,
            ),
          )
        else
          Container(),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                event.eventName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff694A85),
                  // ),
                ),
              ),
              Text(
                event.location ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff694A85),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
