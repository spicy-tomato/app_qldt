import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_crawler/view/request_download.dart';
import 'package:app_qldt/_repositories/user_repository/src/user_repository.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_qldt/_models/account_permission_enum.dart';

class CrawlablePage extends StatefulWidget {
  final Widget child;
  final ServiceController controller;

  const CrawlablePage({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  _CrawlablePageState createState() => _CrawlablePageState();
}

class _CrawlablePageState extends State<CrawlablePage> {
  @override
  Widget build(BuildContext context) {
    final permission = context.read<UserRepository>().userDataModel.accountPermission;

    return BlocProvider<CrawlerBloc>(
      create: (_) => CrawlerBloc(context),
      child: BlocBuilder<CrawlerBloc, CrawlerState>(
        buildWhen: (previous, current) => current.status.isOk,
        builder: (context, state) {
          return widget.controller.connected
              ? widget.child
              : permission.isUser
                  ? const RequestQldtPasswordPage()
                  : const RequestDownloadPage();
        },
      ),
    );
  }
}
