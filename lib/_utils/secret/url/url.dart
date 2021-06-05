import 'package:app_qldt/_utils/secret/url/base.dart';
import 'package:app_qldt/_widgets/model/app_mode.dart';

import 'get.dart';
import 'post.dart';

class ApiUrl {
  late final GetRequest get;
  late final PostRequest post;

  ApiUrl(AppMode mode){
    Host host = Host(mode);

    get = GetRequest(host);
    post = PostRequest(host);
  }
}
