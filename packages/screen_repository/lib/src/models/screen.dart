import 'package:equatable/equatable.dart';

enum ScreenPage { home, notification }

class Screen extends Equatable {
  final ScreenPage screenPage;

  const Screen({
    this.screenPage = ScreenPage.home,
  });

  @override
  List<Object> get props => [screenPage];
}
