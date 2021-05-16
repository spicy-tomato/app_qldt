import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_widgets/wrapper/item.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RequestQldtPasswordPage extends StatefulWidget {
  @override
  _RequestQldtPasswordPageState createState() => _RequestQldtPasswordPageState();
}

class _RequestQldtPasswordPageState extends State<RequestQldtPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SharedUI(
      stable: false,
      child: BlocListener<CrawlerBloc, CrawlerState>(
        listener: (BuildContext context, state) {
          if (state.status.isFailed) {
            showDialog(
              context: context,
              builder: (_) => _SystemErrorDialog(),
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
                  _Instructor(),
                  SizedBox(height: 10),
                  _PasswordField(),
                  SizedBox(height: 15),
                  _Button(),
                  SizedBox(height: 25),
                  _Note(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SystemErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  }
}

class _Instructor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Để sử dụng chức năng này, bạn cần cung cấp mật khẩu của bạn trên trang qldt.utc.edu.vn',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          BlocBuilder<CrawlerBloc, CrawlerState>(
            buildWhen: (previous, current) =>
                previous.password != current.password ||
                previous.hidePassword != current.hidePassword,
            builder: (context, state) {
              return TextField(
                onChanged: (password) =>
                    context.read<CrawlerBloc>().add(CrawlerPasswordChanged(password)),
                obscureText: state.hidePassword,
                decoration: InputDecoration(
                  errorText: state.password.invalid
                      ? 'Mật khẩu không được để trống'
                      : state.status.isInvalidPassword
                          ? 'Mật khẩu không chính xác'
                          : null,
                  contentPadding: const EdgeInsets.only(right: 48),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_red_eye),
            iconSize: 20,
            onPressed: () => context.read<CrawlerBloc>().add(CrawlerPasswordVisibleChanged()),
          )
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrawlerBloc, CrawlerState>(
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
    );
  }
}

class _Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '* Quá trình này có thể lên đến năm phút',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).backgroundColor,
        fontSize: 14,
      ),
    );
  }
}
