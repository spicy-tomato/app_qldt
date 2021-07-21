import 'package:app_qldt/plan/plan.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_widgets/bottom_note/bottom_note.dart';
import 'package:app_qldt/_widgets/wrapper/navigable_plan_page.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return NavigablePlanPage(
      child: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          return SharedUI(
            onWillPop: () {
              if (!state.visibility.isClosed) {
                context.read<PlanBloc>().add(ClosePlanPage());
                return Future.value(false);
              }

              return Future.value(null);
            },
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
          );
        },
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
        style: TextStyle(fontSize: 35),
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
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
