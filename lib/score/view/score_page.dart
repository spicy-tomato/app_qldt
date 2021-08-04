import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_widgets/element/auto_hide_message_dialog.dart';
import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/element/refresh_button.dart';
import 'package:app_qldt/_widgets/wrapper/crawlable_page.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:app_qldt/score/bloc/enum/score_page_status.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'local_widgets/local_widgets.dart';

class ScorePage extends StatefulWidget {
  ScorePage({Key? key}) : super(key: key);

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
      controller: context.read<UserRepository>().userDataModel.scoreServiceController,
      child: BlocProvider<ScoreBloc>(
        create: (_) => ScoreBloc(context),
        child: SharedUI(
          stable: false,
          topRightWidget: _refreshButton(),
          child: Stack(
            children: <Widget>[
              BlocBuilder<ScoreBloc, ScoreState>(
                buildWhen: (previous, current) =>
                    (previous.semester.hasData && !current.semester.hasData) ||
                    (!previous.semester.hasData && current.semester.hasData),
                builder: (context, state) {
                  return state.semester.hasData
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ScoreFilter(),
                            ScorePageTable(scrollControllers: widget._scrollControllers),
                          ],
                        )
                      : const Center(
                          child: Text('Chưa có dữ liệu'),
                        );
                },
              ),
              BlocBuilder<ScoreBloc, ScoreState>(
                buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  return state.status.isLoading
                      ? const Loading()
                      : state.status.isFailed
                          ? AutoHideMessageDialog(
                              onClose: () => _onClose(context),
                              message: 'Không thể làm mới do lỗi hệ thống, vui lòng thử lại sau',
                              icon: const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                            )
                          : state.status.isSuccess
                              ? AutoHideMessageDialog(
                                  onClose: () => _onClose(context),
                                  message: 'Làm mới dữ liệu thành công',
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                )
                              : Container();
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

  void _onClose(BuildContext currentContext) {
    currentContext.read<ScoreBloc>().add(const ScorePageStatusChanged(ScorePageStatus.unknown));
  }
}
