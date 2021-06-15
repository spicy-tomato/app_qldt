import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/plan/bloc/plan_bloc.dart';

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
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff26153B),
        ),
        child: TextButton(
          onPressed: () {
            if (useCurrentTime == null || useCurrentTime!) {
              context.read<PlanBloc>().add(PlanTimeChangedToCurrentTime());
            }
            context.read<PlanBloc>().add(OpenPlanPage());
          },
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bạn có dự định gì không?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff85749C),
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
    return Align(
      alignment: Alignment(1, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Material(
          shape: addNoteButtonShape(),
          color: Color(0xff694A85),
          child: InkWell(
            customBorder: addNoteButtonShape(),
            onTap: () {
              if (useCurrentTime == null || useCurrentTime!) {
                context.read<PlanBloc>().add(PlanTimeChangedToCurrentTime());
              }
              context.read<PlanBloc>().add(OpenPlanPage());
            },
            child: Align(
              alignment: Alignment(-0.7, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Thêm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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
