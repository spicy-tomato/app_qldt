import 'package:app_qldt/_models/new_event_model.dart';
import 'package:app_qldt/_models/user_data_model.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/schedule/schedule.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/plan/bloc/plan_bloc.dart';

class PlanPageTopbar extends StatefulWidget {
  final Function()? onCloseButtonTap;

  const PlanPageTopbar({
    Key? key,
    this.onCloseButtonTap,
  }) : super(key: key);

  @override
  _PlanPageTopbarState createState() => _PlanPageTopbarState();
}

class _PlanPageTopbarState extends State<PlanPageTopbar> {
  late UserDataModel _userDataModel;

  @override
  void initState() {
    super.initState();
    _userDataModel = context.read<UserRepository>().userDataModel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () {
              context.read<PlanBloc>().add(ClosePlanPage());
              if (widget.onCloseButtonTap != null) {
                widget.onCloseButtonTap!.call();
              }
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Icon(
              Icons.close,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Container(
            width: 80,
            height: 40,
            child: Material(
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                ),
                onPressed: _onPressed,
                child: const Center(
                  child: Text(
                    'Lưu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressed() async {
    switch (context.read<PlanBloc>().state.type) {
      case PlanType.create:
        await _saveNewEvent();
        break;

      case PlanType.editSchedule:
        await _saveModifiedSchedule();
        break;

      default:
        await _saveModifiedEvent();
    }
  }

  Future<void> _saveNewEvent() async {
    final state = context.read<PlanBloc>().state;

    NewEventModel event = NewEventModel(
      eventName: state.title,
      color: state.color,
      isAllDay: state.isAllDay,
      description: state.description,
      location: state.location,
      from: state.fromDay,
      to: state.toDay,
    );

    await _userDataModel.eventServiceController.saveNewEvent(event.toMap());

    context.read<ScheduleBloc>().add(AddEvent(event));
    context.read<PlanBloc>().add(ClosePlanPage());
  }

  Future<void> _saveModifiedSchedule() async {}

  Future<void> _saveModifiedEvent() async {}
}
