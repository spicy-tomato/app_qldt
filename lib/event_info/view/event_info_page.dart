import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/_widgets/wrapper/hide_tooltip.dart';
import 'package:app_qldt/plan/plan.dart';

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
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _Topbar(
                widget.context,
                event: widget.event,
              ),
              SizedBox(height: 10),
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
                  style: TextStyle(fontSize: 23),
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
                      leading: Icon(Icons.location_on_outlined),
                      title: Text(widget.event.location!),
                    ),
              widget.event.description == null || widget.event.description == ''
                  ? Container()
                  : ListTile(
                      horizontalTitleGap: 4,
                      leading: Icon(Icons.sticky_note_2_outlined),
                      title: Text(widget.event.description!),
                    ),
              widget.event.people == null || widget.event.people == ''
                  ? Container()
                  : ListTile(
                      horizontalTitleGap: 4,
                      leading: Icon(Icons.people_alt_outlined),
                      title: Text(widget.event.people!),
                    )
            ],
          ),
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
          icon: Icon(Icons.clear),
          onPressed: _onClose,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              splashRadius: 25,
              icon: Icon(Icons.edit_outlined),
              onPressed: _onEdit,
            ),
            HideTooltip(
              child: InkWell(
                child: PopupMenuButton<_DropdownOption>(
                  tooltip: '',
                  onSelected: _onSelect,
                  icon: Icon(Icons.more_vert),
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
    print('Delete event');
  }

  void _duplicateEvent() {
    print('Duplicate event');
  }
}
