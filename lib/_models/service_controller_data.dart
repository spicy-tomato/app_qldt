import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';

class ServiceControllerData {
  final DatabaseProvider databaseProvider;
  final ApiUrl apiUrl;
  final String idUser;

  ServiceControllerData({
    required this.databaseProvider,
    required this.apiUrl,
    required this.idUser,
  });
}
