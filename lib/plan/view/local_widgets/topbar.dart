import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/plan/bloc/plan_bloc.dart';

class PlanPageTopbar extends StatelessWidget {
  final Function()? onCloseButtonTap;

  const PlanPageTopbar({
    Key? key,
    this.onCloseButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () {
              context.read<PlanBloc>().add(ClosePlanPage());
              if (onCloseButtonTap != null) {
                onCloseButtonTap!.call();
              }
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Icon(
              Icons.close,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Container(
            width: 80,
            height: 40,
            child: Material(
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                ),
                onPressed: () {
                  print('Save button pressed!');
                },
                child: const Center(
                  child: Text(
                    'Lưu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
