part of 'calendar_widgets.dart';

class DayWidget extends StatelessWidget {
  final DateTime date;

  const DayWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (date.weekday == DateTime.sunday) {
      return Center(
        child: Text(
          '${date.day}',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      );
    }

    return Center(
      child: Text('${date.day}'),
    );
  }
}
