import 'package:app_qldt/_models/receive_notification_model.dart';
import 'package:app_qldt/_models/sender_model.dart';
import 'package:app_qldt/_models/service_controller_data.dart';
import 'package:app_qldt/_services/api/api_notification_service.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_services/local/local_notification_service.dart';
import 'package:app_qldt/_services/model/service_response.dart';

class NotificationServiceController
    extends ServiceController<LocalNotificationService, ApiNotificationService> {
  NotificationServiceController(ServiceControllerData data, String idAccount)
      : super(
          LocalNotificationService(databaseProvider: data.databaseProvider),
          ApiNotificationService(
            apiUrl: data.apiUrl,
            idAccount: idAccount,
            idStudent: data.idUser,
          ),
        );

  List get notificationData => localService.notificationData;

  Future<void> refresh({bool getAll = false}) async {
    ServiceResponse response = getAll ? await apiService.requestAll() : await apiService.request();

    if (response.statusCode == 200) {
      List<SenderModel>? senderList = SenderModel.fromList(response.data['sender']);
      List<ReceiveNotificationModel>? notificationList =
          ReceiveNotificationModel.fromList(response.data['notification']);
      List<int>? deleteList;
      if (response.data['index_del'] != null) {
        deleteList = List.generate(
            response.data['index_del'].length, (index) => response.data['index_del'][index] as int);
      }

      await localService.saveNewData(senderList, notificationList, deleteList);
      await localService.updateVersion(response.version!);
    } else {
      if (response.statusCode == 204) {
        print('There are no new data');
      } else {
        print('Error with status code: ${response.statusCode} at notification_service_controller.dart');
      }
    }
  }

  Future<void> load() async {
    await localService.loadOldData();
  }
}
