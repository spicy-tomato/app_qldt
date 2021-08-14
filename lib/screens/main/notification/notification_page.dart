import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/blocs/notification/notification_bloc.dart';
import 'package:app_qldt/repositories/user_repository/user_repository.dart';
import 'package:app_qldt/screens/sub/notification_post/notification_post_page.dart';
import 'package:app_qldt/services/controller/notification_service_controller.dart';
import 'package:app_qldt/models/notification/user_notification_model.dart';
import 'package:app_qldt/widgets/component/item.dart';
import 'package:app_qldt/widgets/wrapper/shared_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _refreshController = RefreshController(initialRefresh: false);
  final _panelController = PanelController();
  NotificationServiceController? _notificationServiceController;

  @override
  Widget build(BuildContext context) {
    _notificationServiceController ??= context.read<UserRepository>().userDataModel.notificationServiceController;

    List notificationData = _notificationServiceController!.notificationData as List<UserNotificationModel>;

    return InheritedPanelController(
      panelController: _panelController,
      child: BlocProvider<NotificationBloc>(
        create: (_) => NotificationBloc(),
        child: Stack(
          children: <Widget>[
            SharedUI(
              onWillPop: () async {
                if (_panelController.isPanelOpen) {
                  await _panelController.close();
                  return Future.value(false);
                }

                return Future.value(null);
              },
              stable: false,
              child: Item(
                child: SmartRefresher(
                  enablePullDown: true,
                  header: const ClassicHeader(),
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
            ),
            SlidingUpPanel(
              minHeight: 0,
              maxHeight: MediaQuery.of(context).size.height,
              controller: _panelController,
              panelBuilder: (scrollController) {
                return BlocBuilder<NotificationBloc, NotificationState>(
                  buildWhen: (previous, current) => previous.notification != current.notification,
                  builder: (context, state) {
                    if (state.notification == null) {
                      return Container();
                    }

                    return NotificationPostPage(
                      notification: state.notification!,
                      scrollController: scrollController,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    await _notificationServiceController!.refresh();
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
      _refreshController.loadComplete();
    }
  }
}

class ListItem extends StatelessWidget {
  final UserNotificationModel notification;

  const ListItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        context.read<NotificationBloc>().add(NotificationChanged(notification));
        await InheritedPanelController.of(context).panelController.open();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
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
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      notification.senderName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: themeData.secondaryTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      notification.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: themeData.secondaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              DateFormat('d/M').format(notification.timeCreated),
              style: TextStyle(
                color: themeData.secondaryTextColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InheritedPanelController extends InheritedWidget {
  final PanelController panelController;

  const InheritedPanelController({
    Key? key,
    required this.panelController,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritedPanelController of(BuildContext context) {
    final InheritedPanelController? result = context.dependOnInheritedWidgetOfExactType<InheritedPanelController>();
    assert(result != null, 'No InheritedScrollToPlanPage found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(oldWidget) => false;
}
