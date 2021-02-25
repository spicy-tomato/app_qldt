import 'package:equatable/equatable.dart';

enum ScreenPage { Home, Notification }

class Screen extends Equatable {
  final ScreenPage screenPage;

  const Screen({
    this.screenPage = ScreenPage.Home,
  });

  @override
  List<Object> get props => [screenPage];
}
