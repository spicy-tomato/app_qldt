import 'package:app_qldt/_widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:app_qldt/app/app.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    List<dynamic> notificationData = UserDataModel.of(context)!.localNotificationService.notificationData;

    return Item(
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
            return Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  title: Text(
                    notificationData[index].title,
                  ),
                  subtitle: Text(
                    notificationData[index].content,
                  ),
                  onTap: () => print(notificationData[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onRefresh() async {
    await UserDataModel.of(context)!.localNotificationService.refresh();
    await Future.delayed(Duration(milliseconds: 800));
    _refreshController.refreshCompleted();
    setState(() {

    });
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
      _refreshController.loadComplete();
    }
  }
}
