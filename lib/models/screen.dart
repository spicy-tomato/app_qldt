import 'package:equatable/equatable.dart';

enum ScreenPage { home, notification }

extension ScreenPageExtension on ScreenPage {
  String get string {
    switch (this) {
      case ScreenPage.home:
        return 'Thời khoá biểu';

      default:
        return 'Thông báo';
    }
  }
}

class Screen extends Equatable {
  final ScreenPage screenPage;

  const Screen({
    this.screenPage = ScreenPage.home,
  });

  @override
  List<Object> get props => [screenPage];
}
