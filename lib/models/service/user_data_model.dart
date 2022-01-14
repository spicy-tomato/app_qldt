import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:app_qldt/services/controller/event_service_controller.dart';
import 'package:app_qldt/services/controller/exam_schedule_service_controller.dart';
import 'package:app_qldt/services/controller/notification_service_controller.dart';
import 'package:app_qldt/services/controller/score_service_controller.dart';

class UserDataModel {
  final EventServiceController eventServiceController;
  final ScoreServiceController scoreServiceController;
  final NotificationServiceController notificationServiceController;
  final ExamScheduleServiceController examScheduleServiceController;
  final String idAccount;
  final String idUser;
  final AccountPermission accountPermission;
  String avatarPath;

  UserDataModel({
    required this.eventServiceController,
    required this.scoreServiceController,
    required this.notificationServiceController,
    required this.examScheduleServiceController,
    required this.idAccount,
    required this.idUser,
    required this.accountPermission,
    required this.avatarPath,
  });
}
