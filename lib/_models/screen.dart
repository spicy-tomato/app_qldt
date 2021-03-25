import 'package:equatable/equatable.dart';

enum ScreenPage { login, home, calendar, notification }

extension ScreenPageExtension on ScreenPage {
  String get string {
    switch (this) {
      case ScreenPage.login:
        return '/login';

      case ScreenPage.home:
        return '/home';

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

      case ScreenPage.home:
        return 'Trang chủ';

      case ScreenPage.calendar:
        return 'Lịch';

      case ScreenPage.notification:
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
