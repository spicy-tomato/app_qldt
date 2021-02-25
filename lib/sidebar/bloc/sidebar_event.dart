part of 'sidebar_bloc.dart';

abstract class SidebarEvent extends Equatable {
  const SidebarEvent();

  @override
  List<Object> get props => [];
}

class SidebarStatusChanged extends SidebarEvent {
  final SidebarStatus status;

  const SidebarStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class SidebarCloseRequested extends SidebarEvent {}

class SidebarOpenRequested extends SidebarEvent {}

//  TODO: Change tab event
