import 'package:app_qldt/score/bloc/enum/status.dart';
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

  final ScrollController _verticalTitleController = ScrollController();
  final ScrollController _verticalBodyController = ScrollController();

  final ScrollController _horizontalBodyController = ScrollController();
  final ScrollController _horizontalTitleController = ScrollController();

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
            BlocBuilder<ScoreBloc, ScoreState>(
              buildWhen: (previous, current) {
                return previous.semester != current.semester;
              },
              builder: (context, state) {
                return ScoreTable(
                  scrollControllers: ScrollControllers(
                    verticalBodyController: widget._verticalBodyController,
                    verticalTitleController: widget._verticalTitleController,
                    horizontalBodyController: widget._horizontalBodyController,
                    horizontalTitleController: widget._horizontalTitleController,
                  ),
                );
              },
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
