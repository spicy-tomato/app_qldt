import 'package:app_qldt/_utils/day_of_week_vn.dart';
import 'package:app_qldt/plan/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_widgets/local_widgets.dart';

class PlanPage extends StatefulWidget {
  final DateTime? from;
  final DateTime? to;
  final ScrollController? controller;

  PlanPage({Key? key, this.from, this.to, this.controller}) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();

  //  TODO: Remove this
  static void showPlanPage(BuildContext context, {Offset? offsetBegin}) {
    Scaffold.of(context).showBottomSheet<void>((_) {
      return PlanPage();
    });
  }

  static void showApartPlanPage(BuildContext context, DateTime from, DateTime to) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      barrierLabel: 'Back screen',
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (_, __, ___) {
        return ApartPlanPage(from: from, to: to);
      },
      transitionBuilder: (_, anim1, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset(0, 0.75),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    DateTime from = widget.from ?? DateTime.now();
    DateTime to = widget.to ?? from.add(Duration(hours: 3));

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image.asset(
                  'images/icon/swipe-down-icon.png',
                  width: 40,
                ),
              ),
              PlanPageTopbar(),
            ],
          ),
          Expanded(
            child: BlocProvider<PlanBloc>(
              create: (BuildContext context) {
                return PlanBloc(from: from, to: to);
              },
              child: BlocBuilder<PlanBloc, PlanState>(
                builder: (context, state) {
                  return ListView(
                    controller: widget.controller,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      PlanPageTime(),
                      PlanPageDivider(context: context),
                      AddGuest(),
                      PlanPageDivider(context: context),
                      Location(),
                      PlanPageDivider(context: context),
                      Describe(),
                      PlanPageDivider(context: context),
                      Accessibility(),
                      PlanPageDivider(context: context),
                      Status(),
                      PlanPageDivider(context: context),
                      PlanColor(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ApartPlanPage extends StatelessWidget {
  final DateTime from;
  final DateTime to;

  const ApartPlanPage({
    Key? key,
    required this.from,
    required this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('Apart_plan_page'),
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.of(context).pop();
              PlanPage.showPlanPage(context, offsetBegin: Offset(0, 0.7));
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'images/icon/minimize-icon.png',
                    width: 80,
                  ),
                ),
                PlanPageTopbar(),
                PlanPageCustomListTile(
                  title: Text(
                    'Thêm tiêu đề',
                    style: PlanPageConstant.hintTextFieldStyle.copyWith(fontSize: 25),
                  ),
                  defaultHeight: false,
                ),
                PlanPageCustomListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      '${DayOfWeekVN.get(from.weekday)}, ngày ${from.day} tháng ${from.month} · ${from.hour}:00 - ${to.hour}:00',
                      style: PlanPageConstant.textFieldStyle,
                    ),
                  ),
                  defaultHeight: false,
                ),
                PlanPageCustomListTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text(
                    'Thêm người',
                    style: PlanPageConstant.hintTextFieldStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
