import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_utils/database/provider.dart';

abstract class LocalService {
  late final DatabaseProvider databaseProvider;
  late final ServiceController controller;
  bool connected = false;

  LocalService(DatabaseProvider? databaseProvider){
    this.databaseProvider = databaseProvider ?? DatabaseProvider();
  }

  ServiceController get serviceController;
}