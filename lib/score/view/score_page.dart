import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_services/web/crawler_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/score/view/crawled_data_score_page.dart';
import 'package:app_qldt/score/view/request_qldt_password_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const columnWidth = <double>[70, 70, 70, 130, 90, 100];

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrawlerBloc>(
      create: (context) => CrawlerBloc(context),
      child: BlocBuilder<CrawlerBloc, CrawlerState>(
        buildWhen: (previous, current) => !previous.status.isOk || current.status.isOk,
        builder: (context, state) {
          if (!UserDataModel.of(context).localScoreService.connected) {
            return RequestQldtPasswordPage();
          }

          return CrawledDataScorePage();
        },
      ),
    );
  }
}
