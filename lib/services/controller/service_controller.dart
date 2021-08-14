import 'package:app_qldt/services/api/api_service.dart';
import 'package:app_qldt/services/local/local_service.dart';

abstract class ServiceController<L extends LocalService, A extends ApiService> {
  final L localService;
  final A apiService;

  ServiceController(this.localService, this.apiService) {
    localService.controller = this;
    apiService.controller = this;
  }

  bool get connected => localService.connected;

  void setConnected() {
    localService.connected = true;
  }
}
