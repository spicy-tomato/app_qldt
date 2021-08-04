import 'package:app_qldt/_models/account_permission_enum.dart';
import 'package:app_qldt/_widgets/model/app_mode.dart';

class Host {
  final AppMode mode;
  AccountPermission accountPermission;

  Host(this.mode) : accountPermission = AccountPermission.user;

  String get base => accountPermission.isUser ? _userBase : _guestBase;

  String get crawlBase => accountPermission.isUser ? _userCrawlBase : _guestCrawlBase;

  /// User
  String get _userBase {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app/';
  }

  String get _userCrawlBase {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app/crawl/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app/crawl/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app/crawl/';
  }

  /// Guest
  String get _guestBase {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app-guest/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app-guest/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app-guest/';
  }

  String get _guestCrawlBase {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app-guest/crawl/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app-guest/crawl/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app-guest/crawl/';
  }
}
