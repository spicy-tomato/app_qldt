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
        return PlanPageCustomListTile(
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
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: listRadioItem(state.color),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  List<Widget> listRadioItem(PlanColors currentColor) {
    List<Widget> widgets = [];

    PlanColors.values.forEach((color) {
      widgets.add(
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: InkWell(
            onTap: () => _onTap(color),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 12,
              ),
              child: Row(
                children: <Widget>[
                  RadioItem(RadioModel(color, color == currentColor ? true : false)),
                  SizedBox(width: 5),
                  Text(
                    color.string,
                    style: PlanPageConstant.textFieldStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });

    return widgets;
  }

  void _onTap(PlanColors? color) {
    if (color != null) {
      context.read<PlanBloc>().add(PlanColorChanged(color));
    }

    Navigator.of(context).pop();
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: _item.isSelected ? _item.color.color : null,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 4,
            color: _item.color.color,
          ),
        ),
      ),
    );
  }
}

class RadioModel {
  final PlanColors color;
  final bool isSelected;

  RadioModel(this.color, this.isSelected);
}
