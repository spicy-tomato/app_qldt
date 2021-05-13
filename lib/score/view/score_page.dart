import 'package:app_qldt/score/bloc/enum/page_status.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:app_qldt/score/view/local_widgets/function_button.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'local_widgets/local_widgets.dart';

const columnWidth = <double>[70, 70, 70, 130, 90, 100];

class ScorePage extends StatefulWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ScrollControllers _scrollControllers = ScrollControllers(
    verticalTitleController: ScrollController(),
    verticalBodyController: ScrollController(),
    horizontalBodyController: ScrollController(),
    horizontalTitleController: ScrollController(),
  );

  ScorePage({Key? key}) : super(key: key);

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreBloc>(
      create: (_) => ScoreBloc(context),
      child: SharedUI(
        stable: false,
        topRightWidget: FunctionButton(),
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Filter(),
                  ScoreTable(scrollControllers: widget._scrollControllers),
                ],
              ),
            ),
            BlocBuilder<ScoreBloc, ScoreState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                return state.status == ScorePageStatus.loading ? Loading() : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
