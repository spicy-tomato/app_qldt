import 'package:app_qldt/_models/event_model.dart';
import 'package:app_qldt/_models/event_schedule_model.dart';
import 'package:app_qldt/_models/schedule_model.dart';
import 'package:app_qldt/_models/service_controller_data.dart';
import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/_services/api/api_event_service.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_services/local/local_event_service.dart';
import 'package:app_qldt/_services/model/service_response.dart';

class EventServiceController extends ServiceController<LocalEventService, ApiEventService> {
  EventServiceController(ServiceControllerData data)
      : super(
          LocalEventService(databaseProvider: data.databaseProvider),
          ApiEventService(
            apiUrl: data.apiUrl,
            idUser: data.idUser,
          ),
        );

  // Map<String, int> get colorMap => localService.colorMap;

  List<UserEventModel> get scheduleData => localService.scheduleData;

  List<UserEventModel> get eventData => localService.eventData;

  Map<DateTime, List<UserEventModel>> get calendarData => localService.calendarData;

  Future<void> refresh() async {
    ServiceResponse response = await apiService.request();

    if (response.statusCode == 200) {
      List<ScheduleModel> newData = _getListModel(response.data);
      await localService.saveNewData(newData);
      await localService.updateVersion(response.version!);
    } else {
      if (response.statusCode == 204) {
        print('There are no new data');
      } else {
        print('Error with status code: ${response.statusCode} at event_service_controller.dart');
      }
    }
  }

  Future<void> load() async {
    await localService.loadOldData();
  }

  Future<void> saveNewEvent(UserEventModel event) async {
    await localService.saveNewEvent(event);
    await localService.loadEvents();
  }

  Future<void> saveModifiedSchedule(EventScheduleModel event) async {
    await localService.saveModifiedSchedule(event);
    await localService.loadEvents();
  }

  Future<void> saveAllModifiedScheduleWithName(String eventName, EventScheduleModel event) async {
    await localService.saveAllModifiedScheduleWithName(eventName, event);
    await localService.loadEvents();
  }

  Future<void> saveModifiedEvent (EventModel event) async {
    await localService.saveModifiedEvent(event);
    await localService.loadEvents();
  }

  List<ScheduleModel> _getListModel(dynamic responseData) {
    List data = responseData as List;
    List<ScheduleModel> listModel = [];

    for (var element in data) {
      listModel.add(ScheduleModel.fromJson(element));
    }

    return listModel;
  }
}
