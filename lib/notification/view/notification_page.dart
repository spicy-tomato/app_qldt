import 'package:app_qldt/notification_post/notification_post.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:app_qldt/_models/user_notification.dart';
import 'package:app_qldt/_widgets/item.dart';
import 'package:app_qldt/_widgets/shared_ui.dart';
import 'package:app_qldt/_widgets/user_data_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _NotificationPageState();

  @override
  Widget build(BuildContext context) {
    List<dynamic> notificationData = UserDataModel.of(context)!
        .localNotificationService
        .notificationData as List<UserNotification>;

    return SharedUI(
      child: Item(
        child: SmartRefresher(
          enablePullDown: true,
          header: ClassicHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.separated(
            separatorBuilder: (_, __) => const Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            itemCount: notificationData.length,
            itemBuilder: (BuildContext context, int index) {
              return ListItem(notification: notificationData[index]);
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    await UserDataModel.of(context)!.localNotificationService.refresh();
    await Future.delayed(Duration(milliseconds: 800));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
      _refreshController.loadComplete();
    }
  }
}

class ListItem extends StatelessWidget {
  final UserNotification notification;

  const ListItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showGeneralDialog(
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 200),
          context: context,
          pageBuilder: (_, __, ___) {
            return NotificationPostPage(notification: notification);
          },
          transitionBuilder: (_, anim1, __, child) {
            return SlideTransition(
              position: Tween(
                begin: Offset(0, 1),
                end: Offset(0, 0),
              ).animate(anim1),
              child: child,
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      notification.senderName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      notification.senderName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    Text(
                      notification.title,
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
              DateFormat.Md().format(DateTime.now()),
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
