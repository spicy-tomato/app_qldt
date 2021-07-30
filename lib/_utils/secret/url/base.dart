import 'package:app_qldt/_widgets/model/app_mode.dart';

class Host {
  final AppMode mode;

  Host(this.mode);

  /// User
  String get base {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app/';
  }

  String get crawlBase {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app/crawl/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app/crawl/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app/crawl/';
  }

  /// Guest
  String get guestBase {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app-guest/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app-guest/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app-guest/';
  }

  String get guestCrawlBase {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app-guest/crawl/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app-guest/crawl/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app-guest/crawl/';
  }
}
