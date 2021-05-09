import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:app_qldt/score/view/local_widgets/function_button.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_models/score.dart';
import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_widgets/local_widgets.dart';

const columnWidth = <double>[70, 70, 70, 130, 90, 100];

class ScorePage extends StatefulWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ScorePage({Key? key}) : super(key: key);

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  // TODO: Remove scoreData
  late List<Score> scoreData;

  @override
  Widget build(BuildContext context) {
    scoreData = UserDataModel.of(context)!.localScoreService.scoreData;

    return BlocProvider<ScoreBloc>(
      create: (_) => ScoreBloc(scoreData),
      child: SharedUI(
        stable: false,
        topRightWidget: FunctionButton(),
        child: Stack(
          children: <Widget>[
            ScoreTable(scoreData),
            _fader(),
          ],
        ),
      ),
    );
  }

  Widget _fader() {
    return ValueListenableBuilder<bool>(
      builder: (_, value, __) {
        return value ? Loading() : Container();
      },
      valueListenable: widget.isLoading,
    );
  }
}
