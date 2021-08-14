enum ScreenPage {
  login,
  home,
  // calendar,
  schedule,
  notification,
  score,
  examSchedule,
  setting
}

extension ScreenPageExtension on ScreenPage {
  String get string {
    switch (this) {
      case ScreenPage.login:
        return '/login';

      case ScreenPage.home:
        return '/home';

      // case ScreenPage.calendar:
      //   return '/calendar';

      case ScreenPage.schedule:
        return '/schedule';

      case ScreenPage.score:
        return '/score';

      case ScreenPage.examSchedule:
        return '/examSchedule';

      case ScreenPage.setting:
        return '/setting';

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

      // case ScreenPage.calendar:
      //   return 'Lịch';

      case ScreenPage.schedule:
        return 'Thời gian biểu';

      case ScreenPage.score:
        return 'Điểm';

      case ScreenPage.examSchedule:
        return 'Lịch thi';

      case ScreenPage.setting:
        return 'Cài đặt';

      case ScreenPage.notification:
      default:
        return 'Thông báo';
    }
  }
}
