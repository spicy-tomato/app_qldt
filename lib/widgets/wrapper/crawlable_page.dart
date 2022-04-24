import 'package:app_qldt/blocs/crawler/crawler_bloc.dart';
import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:app_qldt/enums/crawl/crawler_status.dart';
import 'package:app_qldt/repositories/user_repository/src/user_repository.dart';
import 'package:app_qldt/screens/sub/request_qldt_password/request_download.dart';
import 'package:app_qldt/screens/sub/request_qldt_password/request_qldt_password.dart';
import 'package:app_qldt/services/controller/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final permission = context.read<UserRepository>().userDataModel.role;

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
