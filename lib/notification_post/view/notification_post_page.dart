import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_qldt/_models/user_notification_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationPostPage extends StatefulWidget {
  final UserNotificationModel notification;
  final ScrollController scrollController;

  const NotificationPostPage({
    Key? key,
    required this.notification,
    required this.scrollController,
  }) : super(key: key);

  @override
  _NotificationPostPageState createState() => _NotificationPostPageState();
}

class _NotificationPostPageState extends State<NotificationPostPage> {
  final _linkRegex = RegExp(r'<a>([^<]*[^\/]*[^a]*[^/])<\/a>');
  final _phoneNumberRegex = RegExp(r'[0-9]([0-9. ]){9,12}[0-9]');
  final _textStyle = const TextStyle(
    height: 1.25,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Color(0xff4a2a73),
    fontFamily: 'Montserrat',
  );

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
          const SizedBox(height: 15),
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
          const SizedBox(height: 30),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
          const SizedBox(height: 50),
          _CommonPadding(
            child: SelectableText.rich(
              TextSpan(
                children: _createText(),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  List<TextSpan> _createText() {
    final result = <TextSpan>[];
    String content = widget.notification.content;

    _linkRegex.allMatches(content).forEach((value) {
      final regexMatch = value.group(0)!;
      result.addAll(_createTextSpans(content.split(regexMatch)[0]));
      result.add(_createLinkTextSpan(regexMatch));
      content = content.split(value.group(0)!)[1];
    });

    if (content != '') {
      result.addAll(_createTextSpans(content));
    }

    return result;
  }

  List<TextSpan> _createTextSpans(String text) {
    final result = <TextSpan>[];

    _phoneNumberRegex.allMatches(text).forEach((value) {
      final regexMatch = value.group(0)!;
      result.add(_createTextSpan(text.split(regexMatch)[0]));
      result.add(_createPhoneNumberSpan(regexMatch));
      text = text.split(value.group(0)!)[1];
    });

    if (text != '') {
      result.add(_createTextSpan(text));
    }

    return result;
  }

  TextSpan _createTextSpan(String text) {
    return TextSpan(
      text: text,
      style: _textStyle,
    );
  }

  TextSpan _createPhoneNumberSpan(String phoneNumber) {
    final Uri phoneUrl = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    return TextSpan(
        text: phoneNumber,
        style: _textStyle.copyWith(
          color: const Color(0xff1e2bff),
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            if (await canLaunch(phoneUrl.toString())) {
              await launch(phoneUrl.toString());
            }
          });
  }

  TextSpan _createLinkTextSpan(String text) {
    final url = text.substring(3, text.length - 4);
    final displayText = Uri.decodeComponent(url).split('/').last;

    return TextSpan(
      text: '\n$displayText',
      style: _textStyle.copyWith(
        color: const Color(0xff1e2bff),
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
    );
  }

  String _timeSent() {
    final now = DateTime.now();

    if (now.subtract(const Duration(days: 30)).isAfter(widget.notification.timeCreated)) {
      return widget.notification.timeCreated.toString();
    } else if (now.subtract(const Duration(days: 1)).isAfter(widget.notification.timeCreated)) {
      return '${DateTime.now().difference(widget.notification.timeCreated).inDays} ngày trước';
    } else if (now.subtract(const Duration(hours: 1)).isAfter(widget.notification.timeCreated)) {
      return '${DateTime.now().difference(widget.notification.timeCreated).inHours} giờ trước';
    } else if (now.subtract(const Duration(minutes: 1)).isAfter(widget.notification.timeCreated)) {
      return '${DateTime.now().difference(widget.notification.timeCreated).inMinutes} phút trước';
    } else {
      return '${DateTime.now().difference(widget.notification.timeCreated).inSeconds} giây trước';
    }
  }
}

class _CommonPadding extends Padding {
  const _CommonPadding({
    Key? key,
    required child,
  }) : super(
          key: key,
          child: child,
          padding: const EdgeInsets.symmetric(horizontal: 15),
        );
}
