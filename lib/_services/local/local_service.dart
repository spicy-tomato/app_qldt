import 'package:app_qldt/_utils/database/provider.dart';

class LocalService {
  late final DatabaseProvider databaseProvider;
  bool connected = false;

  LocalService(DatabaseProvider? databaseProvider){
    this.databaseProvider = databaseProvider ?? DatabaseProvider();
  }
}