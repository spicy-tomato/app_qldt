import 'package:flutter/material.dart';

import 'package:app_qldt/_services/local/local_exam_schedule_service.dart';
import 'package:app_qldt/_services/local/local_score_service.dart';
import 'package:app_qldt/_services/local/local_event_service.dart';
import 'package:app_qldt/_services/local/local_notification_service.dart';

class UserDataModel extends InheritedWidget {
  final LocalEventService localEventService;
  final LocalScoreService localScoreService;
  final LocalNotificationService localNotificationService;
  final LocalExamScheduleService localExamScheduleService;

  UserDataModel({
    required this.localEventService,
    required this.localScoreService,
    required this.localNotificationService,
    required this.localExamScheduleService,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(UserDataModel old) => false;

  static UserDataModel of(BuildContext context) {
    final UserDataModel? result = context.dependOnInheritedWidgetOfExactType<UserDataModel>();
    assert(result != null, 'No UserDataModel found in context');

    return result!;
  }
}
