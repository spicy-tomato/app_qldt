import 'dart:math';
import 'package:flutter/material.dart';

import 'package:app_qldt/_models/user_event.dart';

class EventList extends StatelessWidget {
  final List? event;

  const EventList({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (event == null || event!.length == 0) {
      return Container(color: Colors.transparent);
    }

    return Column(
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
              itemCount: min(event!.length, 3),
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
              itemBuilder: (_, index) => _EventListItem(event: event![index]),
            ),
          ),
        ),
        Spacer(),
      ],
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
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Flexible(
              //   child:
              Container(
                child: Text(
                  event.name,
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
          )
        ],
      ),
    );
  }
}
