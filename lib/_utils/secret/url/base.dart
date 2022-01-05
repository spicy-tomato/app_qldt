import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:app_qldt/enums/config/app_mode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Host {
  final AppMode mode;
  AccountPermission accountPermission;

  Host(this.mode) : accountPermission = AccountPermission.user;

  String get base => accountPermission.isUser ? _userBase : _guestBase;

  String get crawlBase => accountPermission.isUser ? _userCrawlBase : _guestCrawlBase;

  /// User
  String get _userBase {
    if (mode.isRelease) {
      return dotenv.env['RELEASE_URL']!;
    }

    if (mode.isStaging) {
      return dotenv.env['STAGE_URL']!;
    }

    return dotenv.env['DEV_URL']!;
  }

  String get _userCrawlBase {
    return '$_userBase/student/crawl/';
  }

  /// Guest
  String get _guestBase {
    if (mode.isRelease) {
      return 'https://utcketnoi.site';
  }

    if (mode.isStaging) {
      return 'https://utcketnoi.site';
    }

    return 'https://utcketnoi.site';
  }

  String get _guestCrawlBase {
    if (mode.isRelease) {
      return 'https://utcketnoi.site/crawl/';
    }

    if (mode.isStaging) {
      return 'https://utcketnoi.site/crawl/';
    }

    return 'https://utcketnoi.site/crawl/';
  }
}
