import 'package:app_qldt/calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

class CalendarHeader extends StatelessWidget {
  final CalendarController calendarController;

  const CalendarHeader({
    Key? key,
    required this.calendarController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _CustomIconButton(
              iconData: Icons.chevron_left,
              onTap: _selectPrevious,
            ),
            Container(
              child: BlocBuilder<CalendarBloc, CalendarState>(
                buildWhen: (previous, current) {
                  return previous.visibleDay != null && previous.visibleDay!.month != current.visibleDay!.month;
                },
                builder: (_, __) {
                  String date = DateFormat.yMMMM('vi_VI').format(calendarController.focusedDay);
                  return Text(
                    date[0].toUpperCase() + date.substring(1),
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            _CustomIconButton(
              iconData: Icons.chevron_right,
              onTap: _selectNext,
            ),
          ],
        ),
      ),
    );
  }

  void _selectPrevious() {
    calendarController.previousPage();
  }

  void _selectNext() {
    calendarController.nextPage();
  }
}

class _CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  const _CustomIconButton({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: EdgeInsets.all(7.5),
          child: Icon(
            iconData,
            color: Colors.white,
            size: 17,
          ),
        ),
      ),
    );
  }
}
