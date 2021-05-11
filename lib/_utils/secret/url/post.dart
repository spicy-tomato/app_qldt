import 'base.dart';

class PostRequest {
  const PostRequest();

  String get upsertToken => Host.base + 'upsert_token.php';
}
