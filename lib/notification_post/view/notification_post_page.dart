import 'package:flutter/material.dart';
import 'package:app_qldt/_models/user_notification_model.dart';
import 'package:intl/intl.dart';

class NotificationPostPage extends StatelessWidget {
  final UserNotificationModel notification;

  const NotificationPostPage({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('Plan_page'),
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ScrollView(notification: notification),
        ),
      ),
    );
  }
}

class ScrollView extends StatefulWidget {
  final UserNotificationModel notification;

  const ScrollView({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  _ScrollViewState createState() => _ScrollViewState();
}

class _ScrollViewState extends State<ScrollView> {
  late ScrollController _controller;
  bool popFlag = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            Icons.keyboard_arrow_down,
            size: 40,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        SizedBox(height: 20),
        Text(
          widget.notification.title,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
        ),
        SizedBox(height: 35),
        Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  widget.notification.senderName[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.notification.senderName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    Text(
                      _timeSent(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              DateFormat('d/M').format(widget.notification.timeCreated),
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 50),
        Text(
          widget.notification.content,
          softWrap: true,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ],
    );
  }

  void _scrollListener() {
    if (_controller.offset <= _controller.position.minScrollExtent && popFlag == false) {
      popFlag = true;
      Navigator.of(context).pop();
    }
  }

  String _timeSent() {
    final now = DateTime.now();

    if (now.subtract(Duration(days: 30)).isAfter(widget.notification.timeCreated)) {
      return widget.notification.timeCreated.toString();
    } else if (now.subtract(Duration(days: 1)).isAfter(widget.notification.timeCreated)) {
      return '${DateTime.now().difference(widget.notification.timeCreated).inDays} ngày trước';
    } else if (now.subtract(Duration(hours: 1)).isAfter(widget.notification.timeCreated)) {
      return '${DateTime.now().difference(widget.notification.timeCreated).inHours} giờ trước';
    } else if (now.subtract(Duration(minutes: 1)).isAfter(widget.notification.timeCreated)) {
      return '${DateTime.now().difference(widget.notification.timeCreated).inMinutes} phút trước';
    } else {
      return '${DateTime.now().difference(widget.notification.timeCreated).inSeconds} giây trước';
    }
  }
}
