import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/repositories/user_repository/src/models/user.dart';

class ServiceControllerData {
  final DatabaseProvider databaseProvider;
  final ApiUrl apiUrl;
  final User user;

  ServiceControllerData({
    required this.databaseProvider,
    required this.apiUrl,
    required this.user,
  });
}
