import 'package:app_qldt/models/event/event_model.dart';
import 'package:app_qldt/models/event/event_schedule_model.dart';
import 'package:app_qldt/models/event/schedule_model.dart';
import 'package:app_qldt/models/event/user_event_model.dart';
import 'package:app_qldt/models/service/service_controller_data.dart';
import 'package:app_qldt/services/api/api_event_service.dart';
import 'package:app_qldt/services/controller/service_controller.dart';
import 'package:app_qldt/services/local/local_event_service.dart';
import 'package:app_qldt/services/model/service_response.dart';
import 'package:flutter/widgets.dart';

class EventServiceController extends ServiceController<LocalEventService, ApiEventService> {
  EventServiceController(ServiceControllerData data)
      : super(
          LocalEventService(databaseProvider: data.databaseProvider),
          ApiEventService(
            apiUrl: data.apiUrl,
            idUser: data.idUser,
          ),
        );

  List<UserEventModel> get scheduleData => localService.scheduleData;

  List<UserEventModel> get eventData => localService.eventData;

  Map<DateTime, List<UserEventModel>> get calendarData => localService.calendarData;

  Future<void> refresh() async {
    final ServiceResponse response = await apiService.request();

    if (response.statusCode == 200) {
      final List<ScheduleModel> newData = _getListModel(response.data);
      await localService.saveNewData(newData);
      await localService.updateVersion(response.version!);
    } else {
      if (response.statusCode == 204) {
        debugPrint('There are no new data');
      } else {
        debugPrint('Error with status code: ${response.statusCode} at event_service_controller.dart');
      }
    }
  }

  Future<void> load() async {
    await localService.loadOldData();
  }

  Future<int?> saveNewEvent(UserEventModel event) async {
    final int? lastId = await localService.saveNewEvent(event);
    await localService.loadEvents();

    return lastId;
  }

  Future<void> saveModifiedEvent(EventModel event) async {
    await localService.saveModifiedEvent(event);
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

  Future<void> deleteEvent(int id) async {
    await localService.deleteEvent(id);
    await localService.loadEvents();
  }

  List<ScheduleModel> _getListModel(dynamic responseData) {
    final List data = responseData as List;
    final List<ScheduleModel> listModel = [];

    for (var element in data) {
      listModel.add(ScheduleModel.fromJson(element));
    }

    return listModel;
  }
}
