part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationChanged extends NotificationEvent {
  final UserNotificationModel notification;

  const NotificationChanged(this.notification);

  @override
  List<Object> get props => [notification];
}
