import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:app_qldt/models/screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'screen_event.dart';

part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(ScreenState.defaultPage());

  @override
  Stream<ScreenState> mapEventToState(
    ScreenEvent event,
  ) async* {
    if (event is ScreenPageChanged) {
      _mapScreenPageChangedToState(event);
    }
  }

  ScreenState _mapScreenPageChangedToState(
    ScreenPageChanged event,
  ) {
    switch (event.screenPage) {
      case ScreenPage.home:
        return const ScreenState.home();

      case ScreenPage.notification:
        return const ScreenState.notification();

      default:
        return const ScreenState.defaultPage();
    }
  }
}
