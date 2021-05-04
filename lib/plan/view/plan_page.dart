import 'package:flutter/material.dart';

import 'local_widgets/local_widgets.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      PlanPageTopbar(),
                      PlanPageTitle(),
                      PlanPageDivider(context: context),
                      PlanPageTime(),
                      PlanPageDivider(context: context),
                      AddPeople(),
                      PlanPageDivider(context: context),
                      Location(),
                      PlanPageDivider(context: context),
                      Describe(),
                      PlanPageDivider(context: context),
                      Display(),
                      PlanPageDivider(context: context),
                      Status(),
                    ],
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
