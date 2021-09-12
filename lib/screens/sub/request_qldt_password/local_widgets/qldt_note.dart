import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';

class QldtNote extends StatelessWidget {
  const QldtNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Text(
      '* Quá trình này có thể lên đến năm phút',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: themeData.secondaryTextColor,
        fontSize: 14,
      ),
    );
  }
}
