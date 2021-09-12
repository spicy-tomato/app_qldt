part of 'calendar_widgets.dart';

class TodayInFocusedMonthWidget extends StatelessWidget {
  final DateTime date;

  const TodayInFocusedMonthWidget({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xffD55C7D),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Center(
          child: Text(
            '${date.day}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class TodayOutFocusedMonthWidget extends StatelessWidget {
  final DateTime date;

  const TodayOutFocusedMonthWidget({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xffD55C7D),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Center(
          child: Text(
            '${date.day}',
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
