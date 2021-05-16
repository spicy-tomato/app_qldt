import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrawlablePage extends StatefulWidget {
  final Widget child;

  const CrawlablePage({Key? key, required this.child}) : super(key: key);

  @override
  _CrawlablePageState createState() => _CrawlablePageState();
}

class _CrawlablePageState extends State<CrawlablePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrawlerBloc>(
      create: (_) => CrawlerBloc(context),
      child: BlocBuilder<CrawlerBloc, CrawlerState>(
        buildWhen: (previous, current) => !previous.status.isOk || current.status.isOk,
        builder: (context, state) {
          if (!UserDataModel.of(context).localScoreService.connected) {
            return RequestQldtPasswordPage();
          }

          return widget.child;
        },
      ),
    );
  }
}
