import 'package:app_qldt/enums/config/app_mode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Host {
  final AppMode mode;

  Host(this.mode);

  String get base => _userBase;

  String get crawlBase => _userCrawlBase;

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
}
