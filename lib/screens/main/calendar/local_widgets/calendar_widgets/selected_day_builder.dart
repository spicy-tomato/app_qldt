part of 'calendar_widgets.dart';

class SelectedDayWidget extends StatelessWidget {
  final DateTime date;
  final AnimationController animationController;

  const SelectedDayWidget(this.date, this.animationController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: Center(
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: Const.calendarDayFontSize,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
