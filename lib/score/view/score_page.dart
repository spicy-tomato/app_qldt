import 'package:flutter/material.dart';

import 'package:app_qldt/_models/score.dart';
import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/element/refresh_button.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';

import 'local_widgets/local_widgets.dart';

const columnWidth = <double>[70, 70, 70, 130, 90, 100];

class ScorePage extends StatefulWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ScorePage({Key? key}) : super(key: key);

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late List<Score> scoreData;

  @override
  Widget build(BuildContext context) {
    scoreData = UserDataModel.of(context)!.localScoreService.scoreData;

    return SharedUI(
      topRightWidget: _refreshButton(context),
      child: Stack(
        children: <Widget>[
          ScoreTable(scoreData),
          _fader(),
        ],
      ),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return RefreshButton(
      context,
      onTap: () async {
        widget.isLoading.value = true;

        await UserDataModel.of(context)!.localScoreService.refresh();
        scoreData = UserDataModel.of(context)!.localScoreService.scoreData;

        widget.isLoading.value = false;

        setState(() {});
      },
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
