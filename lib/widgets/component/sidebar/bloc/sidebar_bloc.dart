import 'dart:async';

import 'package:app_qldt/enums/config/screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sidebar_event.dart';

part 'sidebar_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(const ScreenState.home());

  @override
  Stream<ScreenState> mapEventToState(ScreenEvent event) async* {
    if (event is ScreenPageChange) {
      yield _mapScreenPageChangeToState(event);
    }
  }

  ScreenState _mapScreenPageChangeToState(
    ScreenPageChange event,
  ) {
    switch (event.screenPage) {
      case ScreenPage.notification:
        return const ScreenState.notification();

      default:
        return const ScreenState.home();
    }
  }
}
