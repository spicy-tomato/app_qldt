import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:app_qldt/_services/local_notification_service.dart';
import 'package:app_qldt/_services/local_event_service.dart';

enum ServiceEnum {
  notification,
  schedule,
}

class UserDataModel extends InheritedModel<ServiceEnum> {
  final LocalNotificationService localNotificationService;
  final LocalEventService localEventService;

  UserDataModel({
    required this.localNotificationService,
    required this.localEventService,
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
        );
  }

  @override
  bool updateShouldNotifyDependent(UserDataModel old, Set<ServiceEnum> aspect) {
    return (aspect.contains(ServiceEnum.notification) &&
        !DeepCollectionEquality().equals(
          localNotificationService.notificationData,
          old.localNotificationService.notificationData,
        )) ||
        (aspect.contains(ServiceEnum.notification) &&
            !DeepCollectionEquality().equals(
              localEventService.eventsData,
              old.localEventService.eventsData,
            ));
  }

  static UserDataModel? of(BuildContext context, {ServiceEnum? aspect}) {
    return InheritedModel.inheritFrom<UserDataModel>(context, aspect: aspect);
  }
}