import 'package:app_qldt/_widgets/bottom_note/bottom_note.dart';
import 'package:app_qldt/_widgets/bottom_note/view/bottom_note.dart';
import 'package:app_qldt/_widgets/inherited_scroll_to_plan_page.dart';
import 'package:app_qldt/_widgets/shared_ui.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return InheritedScrollToPlanPage(
      panelController: _panelController,
      child: Stack(
        children: <Widget>[
          SharedUI(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).backgroundColor,
                ],
              ),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Greeting(),
                  Art(),
                  Quote(),
                  BottomNote(),
                ],
              ),
            ),
          ),
          SlidingUpPanel(
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height,
            controller: _panelController,
            panelBuilder: (scrollController) {
              return PlanPage(controller: scrollController);
            },
          ),
        ],
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        'Xin chào',
        style: TextStyle(
          fontSize: 35,
        ),
      ),
    );
  }
}

class Art extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 170,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
      ),
    );
  }
}

class Quote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text(
          'No pain, no gain',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
