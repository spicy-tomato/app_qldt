import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:app_qldt/_services/local/local_score_service.dart';
import 'package:app_qldt/_services/local/local_event_service.dart';
import 'package:app_qldt/_services/local/local_notification_service.dart';

enum ServiceEnum {
  notification,
  schedule,
  score,
}

class UserDataModel extends InheritedModel<ServiceEnum> {
  final LocalNotificationService localNotificationService;
  final LocalEventService localEventService;
  final LocalScoreService localScoreService;

  UserDataModel({
    required this.localNotificationService,
    required this.localEventService,
    required this.localScoreService,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(UserDataModel old) {
    return !DeepCollectionEquality().equals(
          localEventService.eventsData,
          old.localEventService.eventsData,
        ) ||
        !DeepCollectionEquality().equals(
          localNotificationService.notificationData,
          old.localNotificationService.notificationData,
        ) ||
        !DeepCollectionEquality().equals(
          localScoreService.scoreData,
          old.localScoreService.scoreData,
        );
  }

  @override
  bool updateShouldNotifyDependent(UserDataModel old, Set<ServiceEnum> aspect) {
    //  Local Notification data change
    if (aspect.contains(ServiceEnum.notification) &&
        !DeepCollectionEquality().equals(
          localNotificationService.notificationData,
          old.localNotificationService.notificationData,
        )) {
      return true;
    }

    //  Local Event data change
    if (aspect.contains(ServiceEnum.schedule) &&
        !DeepCollectionEquality().equals(
          localEventService.eventsData,
          old.localEventService.eventsData,
        )) {
      return true;
    }

    //  Local Score data change
    if (aspect.contains(ServiceEnum.score) &&
        !DeepCollectionEquality().equals(
          localScoreService.scoreData,
          old.localScoreService.scoreData,
        )) {
      return true;
    }

    //  Local Score service connected
    if (aspect.contains(ServiceEnum.score) &&
        localScoreService.connected != old.localScoreService.connected) {
      print('Should update');
      return true;
    }

    return false;
  }

  static UserDataModel? of(BuildContext context, {ServiceEnum? aspect}) {
    return InheritedModel.inheritFrom<UserDataModel>(context, aspect: aspect);
  }
}
