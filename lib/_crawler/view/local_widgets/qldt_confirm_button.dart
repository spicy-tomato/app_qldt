import 'package:app_qldt/_crawler/bloc/crawler_bloc.dart';
import 'package:app_qldt/_crawler/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
                          color: Theme.of(context).backgroundColor,
                        ),
                      );
                    },
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
                  context.read<CrawlerBloc>().add(CrawlerPasswordVisibleChanged(hidePassword: true));
                  context.read<CrawlerBloc>().add(needPassword ? CrawlerSubmitted() : CrawlerDownload());
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
                  needPassword ? 'Xác nhận' : 'Tải xuống dữ liệu',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              );
      },
    );
  }
}
