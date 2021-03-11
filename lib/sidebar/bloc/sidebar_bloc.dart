import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:app_qldt/_models/screen.dart';

// ignore: import_of_legacy_library_into_null_safe
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
        return ScreenState.notification();

      default:
        return ScreenState.home();
    }
  }
}
