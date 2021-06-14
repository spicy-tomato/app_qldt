import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/plan/plan.dart';

import 'shared/shared.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<PlanBloc>().state.location;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: TextField(
        controller: _controller,
        onChanged: _onChanged,
        style: PlanPageConstant.textFieldStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Vị trí',
          hintStyle: PlanPageConstant.hintTextFieldStyle,
        ),
      ),
    );
  }

  void _onChanged(String text) {
    context.read<PlanBloc>().add(PlanLocationChanged(text));
  }
}
