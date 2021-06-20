import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/plan/bloc/plan_bloc.dart';

import 'shared/shared.dart';

class Describe extends StatefulWidget {
  @override
  _DescribeState createState() => _DescribeState();
}

class _DescribeState extends State<Describe> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<PlanBloc>().state.description;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: const Icon(Icons.dehaze_outlined),
      title: TextField(
        controller: _controller,
        onChanged: _onChanged,
        style: PlanPageConstant.textFieldStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Mô tả',
          hintStyle: PlanPageConstant.hintTextFieldStyle,
        ),
      ),
    );
  }

  void _onChanged(String text){
    context.read<PlanBloc>().add(PlanDescriptionChanged(text));
  }
}
