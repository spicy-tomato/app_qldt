import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:sidebar_repository/sidebar_repository.dart';
import 'package:tab_repository/tab_repository.dart';

part 'sidebar_event.dart';

part 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  final SidebarRepository _sidebarRepository;
  final ScreenRepository _tabRepository;

  SidebarBloc(
      {@required SidebarRepository sidebarRepository,
      @required ScreenRepository tabRepository})
      : assert(sidebarRepository != null),
        _sidebarRepository = sidebarRepository,
        _tabRepository = tabRepository,
        super(SidebarState.closed()) {
    _sidebarRepository.status.listen(
      (status) => add(SidebarStatusChanged(status)),
    );
  }

  @override
  Stream<SidebarState> mapEventToState(SidebarEvent event) async* {
    if (event is SidebarCloseRequested) {
      yield const SidebarState.closed();
    } else if (event is SidebarOpenRequested) {
      yield const SidebarState.opened();
    }
  }

  // ScreenPage _tryGetTabScreen() {
  //   final tab = _tabRepository.screenPage;
  //   return tab;
  // }
}
