import 'dart:async';

import 'package:app_qldt/_models/user_notification_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is NotificationChanged) {
      yield _mapNotificationChangedToState(event);
    }
  }

  NotificationState _mapNotificationChangedToState(NotificationChanged event) {
    return NotificationState(notification: event.notification);
  }
}
