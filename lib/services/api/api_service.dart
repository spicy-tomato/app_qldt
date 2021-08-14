import 'package:app_qldt/services/controller/service_controller.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';

class ApiService {
  final String idUser;
  late final ServiceController controller;
  final ApiUrl apiUrl;

  ApiService({
    required this.idUser,
    required this.apiUrl,
  });
}
