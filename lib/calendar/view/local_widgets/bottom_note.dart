import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

class BottomNote extends StatelessWidget {
  final CalendarController calendarController;

  const BottomNote({
    Key? key,
    required this.calendarController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Stack(
        children: <Widget>[
          _BottomText(),
          _AddNoteButton(),
        ],
      ),
    );
  }
}

class _BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff26153B),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Bạn có dự định gì không?',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff85749C),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: Color(0xff694A85),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: Align(
          alignment: Alignment(-0.7, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                size: 16,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                'Thêm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
