import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/plan/bloc/plan_bloc.dart';

class PlanPageTitle extends StatefulWidget {
  @override
  _PlanPageTitleState createState() => _PlanPageTitleState();
}

class _PlanPageTitleState extends State<PlanPageTitle> {
  final _textStyle = TextStyle(fontSize: 25);
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<PlanBloc>().state.title;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: BlocBuilder<PlanBloc, PlanState>(
        buildWhen: (previous, current) => previous.title != current.title,
        builder: (context, state) {
          return TextField(
            controller: _controller,
            style: _textStyle,
            onChanged: _onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Thêm tiêu đề',
              hintStyle: _textStyle,
            ),
          );
        },
      ),
    );
  }

  void _onChanged(String title) {
    context.read<PlanBloc>().add(PlanTitleChanged(title));
  }
}
