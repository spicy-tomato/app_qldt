part of 'sidebar_bloc.dart';

abstract class SidebarEvent extends Equatable {
  const SidebarEvent();

  @override
  List<Object> get props => [];
}

class SidebarScreenPageChange extends SidebarEvent {
  final ScreenPage screenPage;

  SidebarScreenPageChange(this.screenPage);

  @override
  List<Object> get props => [screenPage];
}