import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/repositories/user_repository/src/models/user.dart';
import 'package:app_qldt/services/controller/service_controller.dart';

class ApiService {
  final User user;
  late final ServiceController controller;
  final ApiUrl apiUrl;

  ApiService({
    required this.user,
    required this.apiUrl,
  });
}
