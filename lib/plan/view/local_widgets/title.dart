import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/plan/bloc/plan_bloc.dart';

class PlanPageTitle extends StatelessWidget {
  final _textStyle = TextStyle(fontSize: 25);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: BlocBuilder<PlanBloc, PlanState>(
        buildWhen: (previous, current) => previous.title != current.title,
        builder: (context, state) {
          return TextField(
            style: _textStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Thêm tiêu đề',
              hintStyle: _textStyle,
            ),
            onChanged: (title) => context.read<PlanBloc>().add(PlanTitleChanged(title)),
          );
        },
      ),
    );
  }
}
