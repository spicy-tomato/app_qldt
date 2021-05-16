import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/element/refresh_button.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/_widgets/wrapper/crawlable_page.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:app_qldt/score/bloc/enum/page_status.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'local_widgets/local_widgets.dart';

class ScorePage extends StatefulWidget {
  final ScrollControllers _scrollControllers = ScrollControllers(
    verticalTitleController: ScrollController(),
    verticalBodyController: ScrollController(),
    horizontalBodyController: ScrollController(),
    horizontalTitleController: ScrollController(),
  );

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return CrawlablePage(
      service: UserDataModel.of(context).localScoreService,
      child: BlocProvider<ScoreBloc>(
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
                    ScoreFilter(),
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
      ),
    );
  }

  Widget _refreshButton() {
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
