import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/services/controller/service_controller.dart';

abstract class LocalService {
  late final DatabaseProvider databaseProvider;
  late final ServiceController controller;
  bool connected = false;

  LocalService(DatabaseProvider? databaseProvider) {
    this.databaseProvider = databaseProvider ?? DatabaseProvider();
  }

  ServiceController get serviceController;
}
