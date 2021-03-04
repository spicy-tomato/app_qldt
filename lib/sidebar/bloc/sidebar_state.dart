part of 'sidebar_bloc.dart';

class SidebarState extends Equatable {
  final ScreenPage screenPage;

  // TODO: Opening tab
  const SidebarState._({this.screenPage = ScreenPage.home});

  const SidebarState.home() : this._();

  const SidebarState.notification() : this._(screenPage: ScreenPage.notification);

  @override
  List<Object> get props => [screenPage];
}
