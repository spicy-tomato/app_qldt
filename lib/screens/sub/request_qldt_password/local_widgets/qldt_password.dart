import 'package:app_qldt/blocs/crawler/crawler_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class QldtInputPassword extends StatelessWidget {
  const QldtInputPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          BlocBuilder<CrawlerBloc, CrawlerState>(
            buildWhen: (previous, current) =>
                previous.password != current.password ||
                previous.hidePassword != current.hidePassword ||
                previous.status != current.status,
            builder: (context, state) {
              return TextField(
                enabled: !state.formStatus.isSubmissionInProgress,
                onChanged: (password) => context.read<CrawlerBloc>().add(CrawlerPasswordChanged(password)),
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
            onPressed: () => context.read<CrawlerBloc>().add(const CrawlerPasswordVisibleChanged()),
          )
        ],
      ),
    );
  }
}
