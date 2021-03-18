import 'package:equatable/equatable.dart';

enum ScreenPage { login, calendar, notification }

extension ScreenPageExtension on ScreenPage {
  String get string {
    switch (this) {
      case ScreenPage.login:
        return '/login';

      case ScreenPage.calendar:
        return '/calendar';

      default:
        return '/notification';
    }
  }

  String get name {
    switch (this) {
      case ScreenPage.login:
        return 'Đăng xuất';

      case ScreenPage.calendar:
        return 'Lịch';

      default:
        return 'Thông báo';
    }
  }
}

class Screen extends Equatable {
  final ScreenPage screenPage;

  const Screen({
    this.screenPage = ScreenPage.login,
  });

  @override
  List<Object> get props => [screenPage];
}
