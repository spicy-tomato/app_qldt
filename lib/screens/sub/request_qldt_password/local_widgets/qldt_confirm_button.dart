import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/blocs/crawler/crawler_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QldtConfirmButton extends StatelessWidget {
  final bool needPassword;

  final Map<CrawlerStatus, String> textMap = {
    CrawlerStatus.validatingPassword: 'Đang xác thực',
    CrawlerStatus.crawlingScore: 'Đang tải dữ liệu điểm',
    CrawlerStatus.crawlingExamSchedule: 'Đang tải dữ liệu lịch thi',
  };

  QldtConfirmButton({Key? key, this.needPassword = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return BlocBuilder<CrawlerBloc, CrawlerState>(
      buildWhen: (previous, current) => previous.formStatus != current.formStatus,
      builder: (context, state) {
        return state.formStatus.isSubmissionInProgress
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BlocBuilder<CrawlerBloc, CrawlerState>(
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, state) {
                      return Text(
                        textMap[state.status] ?? textMap[CrawlerStatus.validatingPassword]!,
                        style: TextStyle(
                          color: themeData.secondaryTextColor,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(
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
                  context.read<CrawlerBloc>().add(const CrawlerPasswordVisibleChanged(hidePassword: true));
                  context.read<CrawlerBloc>().add(needPassword ? CrawlerSubmitted() : CrawlerDownload());
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  )),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(color: themeData.secondaryTextColor),
                  )),
                ),
                child: Text(
                  needPassword ? 'Xác nhận' : 'Tải xuống dữ liệu',
                  style: TextStyle(
                    color: themeData.secondaryTextColor,
                  ),
                ),
              );
      },
    );
  }
}
