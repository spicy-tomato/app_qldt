part of 'local_widgets.dart';

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
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
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
              color: themeData.secondaryTextColor,
            ),
          ),
          SizedBox(
            width: 80,
            height: 40,
            child: Material(
              color: themeData.primaryColor,
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
      people: state.people,
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
      people: state.people,
    );

    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => ModifyRangeBloc(),
          child: BlocBuilder<ModifyRangeBloc, ModifyRangeState>(
            builder: (context, state) {
              return RadioAlertDialog<ModifyRange>(
                title: const Text(
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
                    child: const Text('Huỷ'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (state.range.isAllEvent) {
                        rootContext.read<ScheduleBloc>().add(ModifyAllSchedulesWithName(event));
                      } else {
                        rootContext.read<ScheduleBloc>().add(ModifySchedule(event));
                      }
                      rootContext.read<PlanBloc>().add(ClosePlanPage());
                    },
                    child: const Text('Lưu'),
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
    final rootContext = context;

    final event = EventModel(
      id: state.id!,
      eventName: state.title,
      description: state.description,
      color: state.color,
      location: state.location,
      people: state.people,
      from: state.fromDay,
      to: state.toDay,
      isAllDay: state.isAllDay,
    );

    rootContext.read<ScheduleBloc>().add(ModifyEvent(event));
    rootContext.read<PlanBloc>().add(ClosePlanPage());
  }
}
