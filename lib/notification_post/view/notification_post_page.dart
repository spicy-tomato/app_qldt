import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_qldt/_models/user_notification_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationPostPage extends StatefulWidget {
  final UserNotificationModel notification;
  final ScrollController scrollController;

  NotificationPostPage({
    Key? key,
    required this.notification,
    required this.scrollController,
  }) : super(key: key);

  @override
  _NotificationPostPageState createState() => _NotificationPostPageState();
}

class _NotificationPostPageState extends State<NotificationPostPage> {
  final _contentRegex = RegExp(r'<a>([^<]*[^\/]*[^a]*[^/])<\/a>');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: widget.scrollController,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 40,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          SizedBox(height: 15),
          _CommonPadding(
            child: Text(
              widget.notification.title,
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
          SizedBox(height: 30),
          _CommonPadding(
            child: Row(
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
          ),
          SizedBox(height: 50),
          _CommonPadding(
            child: RichText(
              text: TextSpan(
                children: _createText(),
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  List<TextSpan> _createText() {
    final result = <TextSpan>[];
    String content = widget.notification.content;

    _contentRegex.allMatches(content).forEach((value) {
      final regexMatch = value.group(0)!;
      result.add(_createTextSpan(content.split(regexMatch)[0]));
      result.add(_createTextSpan(regexMatch, isHyperlink: true));
      content = content.split(value.group(0)!)[1];
    });

    if (content != '') {
      result.add(_createTextSpan(content));
    }

    return result;
  }

  TextSpan _createTextSpan(String text, {bool isHyperlink = false}) {
    if (isHyperlink) {
      final displayUrl = text.substring(3, text.length - 4);
      return TextSpan(
        text: displayUrl.split('/').last,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Color(0xff1e2bff),
          fontFamily: 'Montserrat',
          height: 2,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final url = displayUrl;
            url.replaceAll(' ', '%20');

            if (await canLaunch(url)) {
              await launch(url);
            }
          },
      );
    }

    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Color(0xff4A2A73),
        fontFamily: 'Montserrat',
      ),
    );
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

class _CommonPadding extends Padding {
  _CommonPadding({
    Key? key,
    required child,
  }) : super(
          key: key,
          child: child,
          padding: EdgeInsets.symmetric(horizontal: 15),
        );
}
