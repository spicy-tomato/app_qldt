import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_services/web/crawler_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/_widgets/wrapper/item.dart';
import 'package:app_qldt/score/bloc/enum/page_status.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import 'local_widgets/local_widgets.dart';

const columnWidth = <double>[70, 70, 70, 130, 90, 100];

class ScorePage extends StatefulWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ScrollControllers _scrollControllers = ScrollControllers(
    verticalTitleController: ScrollController(),
    verticalBodyController: ScrollController(),
    horizontalBodyController: ScrollController(),
    horizontalTitleController: ScrollController(),
  );

  ScorePage({Key? key}) : super(key: key);

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
            return _NotLogin();
          }

          return BlocProvider<ScoreBloc>(
            create: (_) => ScoreBloc(context),
            child: SharedUI(
              stable: false,
              // topRightWidget: FunctionButton(),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Filter(),
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
          );
        },
      ),
    );
  }
}

class _NotLogin extends StatefulWidget {
  @override
  _NotLoginState createState() => _NotLoginState();
}

class _NotLoginState extends State<_NotLogin> {
  @override
  Widget build(BuildContext context) {
    return SharedUI(
      stable: false,
      child: BlocListener<CrawlerBloc, CrawlerState>(
        listener: (BuildContext context, state) {
          if (state.status.isFailed) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
                  content: Text('Lỗi hệ thống, vui lòng thử lại sau'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<CrawlerBloc>().add(CrawlerResetStatus());
                      },
                      child: Text('Đồng ý'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Item(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Để sử dụng chức năng này, bạn cần cung cấp mật khẩu của bạn trên trang qldt.utc.edu.vn',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<CrawlerBloc, CrawlerState>(
                      builder: (context, state) {
                        return TextField(
                          decoration: InputDecoration(
                            errorText: state.password.invalid
                                ? 'Mật khẩu không được để trống'
                                : state.status.isInvalidPassword
                                    ? 'Mật khẩu không chính xác'
                                    : null,
                          ),
                          onChanged: (password) {
                            context.read<CrawlerBloc>().add(CrawlerPasswordChanged(password));
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  BlocBuilder<CrawlerBloc, CrawlerState>(
                    buildWhen: (previous, current) => previous.formStatus != current.formStatus,
                    builder: (context, state) {
                      return state.formStatus.isSubmissionInProgress
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Đang tải dữ liệu, vui lòng chờ',
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            )
                          : TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                context.read<CrawlerBloc>().add(CrawlerSubmitted());
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 30,
                                )),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side: BorderSide(color: Theme.of(context).backgroundColor),
                                )),
                              ),
                              child: Text(
                                'Xác nhận',
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(height: 25),
                  Text(
                    '* Quá trình này có thể lên đến năm phút',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
