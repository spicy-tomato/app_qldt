import 'package:app_qldt/_services/api/api_service.dart';
import 'package:app_qldt/_services/local/local_service.dart';

abstract class ServiceController<L extends LocalService, A extends ApiService> {
  final L localService;
  final A apiService;

  ServiceController(this.localService, this.apiService) {
    localService.controller = this;
    apiService.controller = this;
  }

  bool get connected => apiService.connected;

  set connected(bool isConnected) {
    apiService.connected = isConnected;
  }
}
