import 'package:app_qldt/enums/config/role.enum.dart';

enum ScreenPage {
  root,
  login,
  home,
  // calendar,
  schedule,
  notification,
  score,
  examSchedule,
  setting,
  signUp,
  enterInformation
}

extension ScreenPageExtension on ScreenPage {
  String get string {
    switch (this) {
      case ScreenPage.root:
        return '/';

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

      case ScreenPage.signUp:
        return '/signUp';

      case ScreenPage.enterInformation:
        return '/enterInformation';

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

      case ScreenPage.signUp:
        return 'Đăng ký';

      case ScreenPage.enterInformation:
        return 'Nhập thông tin';

      case ScreenPage.notification:
      default:
        return 'Thông báo';
    }
  }

  static List<ScreenPage> displayPagesInSidebar(Role role) {
    return [
      ScreenPage.home,
      ScreenPage.schedule,
      ScreenPage.notification,
      if (role == Role.student) ScreenPage.score,
      ScreenPage.examSchedule,
    ];
  }

  int sidebarIndex (Role role) {
    return displayPagesInSidebar(role).indexOf(this);
  }
}
