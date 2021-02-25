part of 'sidebar_bloc.dart';

class SidebarState extends Equatable {
  final SidebarStatus status;

  // TODO: Opening tab
  const SidebarState._({this.status = SidebarStatus.closed,});

  const SidebarState.closed() : this._();

  const SidebarState.opened() : this._(status: SidebarStatus.opened);

  @override
  List<Object> get props => [status];
}
