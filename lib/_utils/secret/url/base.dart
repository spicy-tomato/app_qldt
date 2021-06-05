import 'package:app_qldt/_widgets/model/app_mode.dart';

class Host {
  final AppMode mode;

  Host(this.mode);

  String get base {
    if (mode.isRelease) {
      return 'https://utcapi.herokuapp.com/api-v2/app/';
    }

    if (mode.isStaging) {
      return 'https://utcapi-staging.herokuapp.com/api-v2/app/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app/';
  }

  String get externalBase {
    if (mode.isRelease){
      return 'https://utcapi.herokuapp.herokuapp.com/api-v2/app/crawl/';
    }

    if (mode.isStaging){
      return 'https://utcapi-staging.herokuapp.com/api-v2/app/crawl/';
    }

    return 'https://utcapi-development.herokuapp.com/api-v2/app/crawl/';
  }
}
