import 'package:flutter/material.dart';

import 'local_widgets/local_widgets.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('Plan_page'),
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 40,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            SizedBox(height: 20),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                PlanPageTopbar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: PlanPageTitle(),
                ),
                PlanPageDivider(context: context),
                PlanPageTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
