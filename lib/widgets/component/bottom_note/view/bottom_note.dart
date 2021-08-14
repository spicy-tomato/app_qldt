import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/blocs/plan/plan_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNote extends StatelessWidget {
  final bool? useCurrentTime;

  const BottomNote({
    Key? key,
    this.useCurrentTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Stack(
        children: <Widget>[
          BottomText(useCurrentTime: useCurrentTime),
          AddNoteButton(useCurrentTime: useCurrentTime),
        ],
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  final bool? useCurrentTime;

  const BottomText({
    Key? key,
    this.useCurrentTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: themeData.bottomNotePrimaryColor,
        ),
        child: TextButton(
          onPressed: () {
            if (useCurrentTime == null || useCurrentTime!) {
              context.read<PlanBloc>().add(PlanTimeChangedToCurrentTime());
            }
            context.read<PlanBloc>().add(const OpenPlanPage());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bạn có dự định gì không?',
                style: TextStyle(
                  color: themeData.bottomNoteSecondaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddNoteButton extends StatelessWidget {
  final bool? useCurrentTime;

  const AddNoteButton({Key? key, this.useCurrentTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Align(
      alignment: const Alignment(1, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Material(
          shape: addNoteButtonShape(),
          color: const Color(0xff694A85),
          child: InkWell(
            customBorder: addNoteButtonShape(),
            onTap: () {
              if (useCurrentTime == null || useCurrentTime!) {
                context.read<PlanBloc>().add(PlanTimeChangedToCurrentTime());
              }
              context.read<PlanBloc>().add(const OpenPlanPage());
            },
            child: Align(
              alignment: const Alignment(-0.7, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 16,
                    color: themeData.primaryTextColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Thêm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: themeData.primaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder addNoteButtonShape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ),
    );
  }
}
