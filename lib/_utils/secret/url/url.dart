import 'package:app_qldt/_utils/secret/url/base.dart';
import 'package:app_qldt/enums/config/app_mode.dart';

import 'get.dart';
import 'post.dart';

class ApiUrl {
  late GetRequest get;
  late PostRequest post;
  late Host host;

  ApiUrl(AppMode mode) : host = Host(mode) {
    get = GetRequest(host);
    post = PostRequest(host);
  }
}
