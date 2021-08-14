import 'package:app_qldt/blocs/plan/plan_bloc.dart';
import 'package:app_qldt/blocs/schedule/schedule_bloc.dart';
import 'package:app_qldt/widgets/wrapper/hide_tooltip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app_qldt/models/event/user_event_model.dart';

enum _DropdownOption {
  delete,
  duplicate,
}

class EventInfoPage extends StatefulWidget {
  final BuildContext context;
  final UserEventModel event;

  const EventInfoPage(
    this.context, {
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _EventInfoPageState createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _Topbar(
              widget.context,
              event: widget.event,
            ),
            const SizedBox(height: 10),
            ListTile(
              horizontalTitleGap: 4,
              leading: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.event.color.color,
                ),
              ),
              title: Text(
                widget.event.eventName,
                style: const TextStyle(fontSize: 23),
                softWrap: true,
              ),
              subtitle: Text(
                widget.event.from == DateTime(now.year, now.month, now.day) ? 'Hôm nay' : _date(),
              ),
            ),
            widget.event.location == null || widget.event.location == ''
                ? Container()
                : ListTile(
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(widget.event.location!),
                  ),
            widget.event.description == null || widget.event.description == ''
                ? Container()
                : ListTile(
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.sticky_note_2_outlined),
                    title: Text(widget.event.description!),
                  ),
            widget.event.people == null || widget.event.people == ''
                ? Container()
                : ListTile(
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.people_alt_outlined),
                    title: Text('${widget.event.type.isSchedule ? 'Gv. ' : ''}${widget.event.people!}'),
                  )
          ],
        ),
      ),
    );
  }

  String _date() {
    return '${DateFormat(
      'E, d MMMM',
      Localizations.localeOf(context).languageCode,
    ).format(widget.event.from!)} · ${DateFormat.Hm().format(widget.event.from!)} - ${DateFormat.Hm().format(widget.event.to!)}';
  }
}

class _Topbar extends StatefulWidget {
  final BuildContext rootContext;
  final UserEventModel event;

  const _Topbar(
    this.rootContext, {
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  __TopbarState createState() => __TopbarState();
}

class __TopbarState extends State<_Topbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: _onClose,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              splashRadius: 25,
              icon: const Icon(Icons.edit_outlined),
              onPressed: _onEdit,
            ),
            HideTooltip(
              child: InkWell(
                child: PopupMenuButton<_DropdownOption>(
                  tooltip: '',
                  onSelected: _onSelect,
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return <PopupMenuEntry<_DropdownOption>>[
                      const PopupMenuItem<_DropdownOption>(
                        value: _DropdownOption.delete,
                        child: Text('Xóa sự kiện'),
                      ),
                      const PopupMenuItem<_DropdownOption>(
                        value: _DropdownOption.duplicate,
                        child: Text('Sao chép'),
                      ),
                    ];
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _onClose() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _onEdit() {
    Navigator.of(context, rootNavigator: true).pop();

    if (widget.event.type == EventType.schedule) {
      widget.rootContext.read<PlanBloc>().add(EditSchedule(widget.event));
    } else if (widget.event.type == EventType.event) {
      widget.rootContext.read<PlanBloc>().add(EditEvent(widget.event));
    }
  }

  void _onSelect(_DropdownOption select) {
    switch (select) {
      case _DropdownOption.delete:
        _deleteEvent();
        break;

      case _DropdownOption.duplicate:
        _duplicateEvent();
        break;

      default:
    }
  }

  void _deleteEvent() {
    if (!widget.event.type.isEvent) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Không thể xóa sự kiện này!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Đồng ý"),
              ),
            ],
          );
        },
      );
    } else {
      widget.rootContext.read<ScheduleBloc>().add(RemoveEvent(widget.event.id));
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _duplicateEvent() {
    debugPrint('Duplicate event');
  }
}
