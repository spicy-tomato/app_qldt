import 'package:flutter/material.dart';

import 'package:app_qldt/_services/controller/event_service_controller.dart';
import 'package:app_qldt/_services/controller/exam_schedule_service_controller.dart';
import 'package:app_qldt/_services/controller/notification_service_controller.dart';
import 'package:app_qldt/_services/controller/score_service_controller.dart';

class UserDataModel extends InheritedWidget {
  final EventServiceController eventServiceController;
  final ScoreServiceController scoreServiceController;
  final NotificationServiceController notificationServiceController;
  final ExamScheduleServiceController examScheduleServiceController;
  final String idAccount;
  final String idStudent;

  UserDataModel({
    required this.eventServiceController,
    required this.scoreServiceController,
    required this.notificationServiceController,
    required this.examScheduleServiceController,
    required this.idAccount,
    required this.idStudent,
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
