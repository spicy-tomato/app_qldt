import 'package:app_qldt/plan/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_widgets/local_widgets.dart';

class PlanPage extends StatefulWidget {
  late final DateTime? from;
  late final DateTime? to;

  PlanPage({Key? key, this.from, this.to}) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState(from, to);
}


class _PlanPageState extends State<PlanPage> {
    late DateTime? from;
    late DateTime? to;

    _PlanPageState(this.from, this.to);

  @override
    Widget build(BuildContext context) {
      if (from == null) {
        from = DateTime.now();
      }

      if (to == null) {
        to = from!.add(Duration(hours: 3));
      }

      return Dismissible(
        key: const Key('Plan_page'),
        direction: DismissDirection.down,
        onDismissed: (_) => Navigator.of(context).pop(),
        child: SafeArea(
          child: Scaffold(
            body: PlanPageConstant(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 40,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  BlocProvider<PlanBloc>(
                    create: (BuildContext context) {
                      return PlanBloc(from: from, to: to);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: BlocBuilder<PlanBloc, PlanState>(
                        builder: (context, state) {
                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              PlanPageTopbar(),
                              PlanPageTitle(),
                              PlanPageDivider(context: context),
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
                            ],
                          );
                        },
                      ),
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