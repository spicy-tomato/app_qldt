import 'package:app_qldt/_models/event_model.dart';
import 'package:app_qldt/_models/event_schedule_model.dart';
import 'package:app_qldt/_widgets/radio_dialog/radio_dialog.dart';
import 'package:app_qldt/plan/modify_range_bloc/modify_range_bloc.dart';
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

    final event = EventModel(
      eventName: state.title,
      color: state.color,
      isAllDay: state.isAllDay,
      description: state.description,
      location: state.location,
      from: state.fromDay,
      to: state.toDay,
    );

    context.read<ScheduleBloc>().add(AddEvent(event));
    context.read<PlanBloc>().add(ClosePlanPage());
  }

  Future<void> _saveModifiedSchedule() async {
    final state = context.read<PlanBloc>().state;
    final rootContext = context;

    final event = EventScheduleModel(
      id: state.id!,
      name: state.title,
      description: state.description,
      color: state.color,
      location: state.location,
    );

    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => ModifyRangeBloc(),
          child: BlocBuilder<ModifyRangeBloc, ModifyRangeState>(
            builder: (context, state) {
              return RadioAlertDialog<ModifyRange>(
                title: Text(
                  'Tuỳ chọn sự kiện',
                  style: TextStyle(color: Colors.black),
                ),
                optionsList: ModifyRange.values,
                currentOption: context.read<ModifyRangeBloc>().state.range,
                stringFunction: ModifyRangeExtension.stringFunction,
                onSelect: (ModifyRange range) {
                  context.read<ModifyRangeBloc>().add(ModifyRangeChanged(range));
                },
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Huỷ'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (state.range.isAllEvent) {
                        rootContext.read<ScheduleBloc>().add(ModifyAllEventsWithName(event));
                      } else {
                        rootContext.read<ScheduleBloc>().add(ModifyEvent(event));
                      }
                      rootContext.read<PlanBloc>().add(ClosePlanPage());
                    },
                    child: Text('Lưu'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _saveModifiedEvent() async {
    final state = context.read<PlanBloc>().state;

    final event = EventModel(
      eventName: state.title,
      color: state.color,
      isAllDay: state.isAllDay,
      description: state.description,
      location: state.location,
      from: state.fromDay,
      to: state.toDay,
    );
    context.read<ScheduleBloc>().add(ReloadEvent(event));

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Lưu Thành công  ✔'
                ,style: TextStyle( fontSize: 20,color: Colors.black,),),

              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: Text('Xác Nhận'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );


    context.read<PlanBloc>().add(ClosePlanPage());

}

}
