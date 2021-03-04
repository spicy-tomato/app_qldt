import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:app_qldt/models/screen.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sidebar_event.dart';

part 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  SidebarBloc() : super(const SidebarState.home());

  @override
  Stream<SidebarState> mapEventToState(SidebarEvent event) async* {
    if (event is SidebarScreenPageChange) {
      yield _mapSidebarScreenPageChange(event);
    }
  }

  SidebarState _mapSidebarScreenPageChange(
    SidebarScreenPageChange event,
  ) {
    switch (event.screenPage) {
      case ScreenPage.notification:
        return SidebarState.notification();

      default:
        return SidebarState.home();
    }
  }
}
