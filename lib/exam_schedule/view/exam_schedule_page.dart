import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/element/refresh_button.dart';
import 'package:app_qldt/_widgets/wrapper/crawlable_page.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:app_qldt/exam_schedule/bloc/exam_schedule_bloc.dart';
import 'package:app_qldt/exam_schedule/view/local_widgets/exam_schedule_table.dart';
import 'package:app_qldt/exam_schedule/view/local_widgets/local_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ExamSchedulePage extends StatefulWidget {
  final ScrollControllers _scrollControllers = ScrollControllers(
    verticalTitleController: ScrollController(),
    verticalBodyController: ScrollController(),
    horizontalBodyController: ScrollController(),
    horizontalTitleController: ScrollController(),
  );

  @override
  _ExamSchedulePageState createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return CrawlablePage(
      child: BlocProvider<ExamScheduleBloc>(
        create: (_) => ExamScheduleBloc(context),
        child: SharedUI(
          stable: false,
          topRightWidget: _refreshButton(),
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ExamScheduleFilter(),
                    ExamScheduleTable(scrollControllers: widget._scrollControllers),
                  ],
                ),
              ),
              BlocBuilder<ExamScheduleBloc, ExamScheduleState>(
                buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  return state.status == ExamSchedulePageStatus.loading ? Loading() : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _refreshButton() {
    return BlocBuilder<ExamScheduleBloc, ExamScheduleState>(
      builder: (context, state) {
        return RefreshButton(
          onTap: () {
            context.read<ExamScheduleBloc>().add(ExamScheduleDataRefresh());
          },
        );
      },
    );
  }
}
