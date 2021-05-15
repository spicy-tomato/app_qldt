import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/element/refresh_button.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:app_qldt/score/bloc/enum/page_status.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'local_widgets/local_widgets.dart';

class CrawledDataScorePage extends StatefulWidget {
  @override
  _CrawledDataScorePageState createState() => _CrawledDataScorePageState();
}

class _CrawledDataScorePageState extends State<CrawledDataScorePage> {
  final ScrollControllers _scrollControllers = ScrollControllers(
    verticalTitleController: ScrollController(),
    verticalBodyController: ScrollController(),
    horizontalBodyController: ScrollController(),
    horizontalTitleController: ScrollController(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreBloc>(
      create: (_) => ScoreBloc(context),
      child: SharedUI(
        stable: false,
        topRightWidget: _refreshButton(),
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Filter(),
                  ScoreTable(scrollControllers: _scrollControllers),
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

  Widget _refreshButton() {
    print(context);
    return BlocBuilder<ScoreBloc, ScoreState>(
      builder: (context, state) {
        return RefreshButton(
          onTap: () {
            context.read<ScoreBloc>().add(ScoreDataRefresh());
          },
        );
      },
    );
  }
}
