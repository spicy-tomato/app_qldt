part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final UserNotificationModel? notification;

  const NotificationState({this.notification});

  @override
  List<Object?> get props => [notification];
}

class NotificationInitial extends NotificationState {
  NotificationInitial() : super();
}
