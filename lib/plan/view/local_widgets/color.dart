import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/_widgets/radio_dialog/radio_dialog.dart';
import 'package:app_qldt/plan/bloc/enum/color.dart';
import 'package:app_qldt/plan/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared/shared.dart';

class PlanColor extends StatefulWidget {
  const PlanColor({Key? key}) : super(key: key);

  @override
  _PlanColorState createState() => _PlanColorState();
}

class _PlanColorState extends State<PlanColor> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      buildWhen: (previous, current) => previous.color != current.color,
      builder: (context, state) {
        return CustomListTile(
          leading: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: state.color.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: Text(
            state.color.string,
            style: PlanPageConstant.textFieldStyle,
          ),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) {
                return RadioAlertDialog<PlanColors>(
                  optionsList: PlanColors.values,
                  currentOption: state.color,
                  stringFunction: PlanColorsExtension.stringFunction,
                  onSelect: _onSelect,
                  radioColorFunction: PlanColorsExtension.colorFunction,
                );
              },
            );
          },
        );
      },
    );
  }

  void _onSelect(PlanColors color) {
    context.read<PlanBloc>().add(PlanColorChanged(color));
    Navigator.of(context).pop();
  }
}
