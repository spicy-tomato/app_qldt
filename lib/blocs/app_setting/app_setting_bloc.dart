import 'dart:async';

import 'package:app_qldt/config/config.dart';
import 'package:app_qldt/enums/config/theme.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

export 'package:app_qldt/enums/config/theme.dart';

part 'app_setting_event.dart';

part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  AppSettingBloc() : super(const AppSettingInitial());

  @override
  Stream<AppSettingState> mapEventToState(
    AppSettingEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield _mapThemeChangedToState(event);
    }
  }

  AppSettingState _mapThemeChangedToState(ThemeChanged event) {
    return state.copyWith(theme: event.theme);
  }
}
