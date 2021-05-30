import 'dart:convert';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrawlablePage extends StatefulWidget {
  final Widget child;
  final LocalService service;

  const CrawlablePage({
    Key? key,
    required this.child,
    required this.service,
  }) : super(key: key);

  @override
  _CrawlablePageState createState() => _CrawlablePageState();
}

class _CrawlablePageState extends State<CrawlablePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          final Map<String, dynamic> userInfo = jsonDecode(snapshot.data!.getString('user_info')!);

          return BlocProvider<CrawlerBloc>(
            create: (_) => CrawlerBloc(
              context,
              idAccount: userInfo['ID'],
              idStudent: userInfo['ID_Student'],
            ),
            child: BlocBuilder<CrawlerBloc, CrawlerState>(
              buildWhen: (previous, current) => !previous.status.isOk || current.status.isOk,
              builder: (context, state) {
                if (!widget.service.connected) {
                  return RequestQldtPasswordPage();
                }

                return widget.child;
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
