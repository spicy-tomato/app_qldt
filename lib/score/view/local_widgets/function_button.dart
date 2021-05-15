import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:app_qldt/score/model/semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ButtonOption {
  filter,
  refresh,
}

class FunctionButton extends StatefulWidget {
  @override
  _FunctionButtonState createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  late List<Semester> semesters;

  @override
  Widget build(BuildContext context) {
    semesters = UserDataModel.of(context).localScoreService.semester;

    return Theme(
      //  Hide tooltip
      data: Theme.of(context).copyWith(
          tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: Colors.transparent))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Material(
          color: Colors.transparent,
          child: BlocBuilder<ScoreBloc, ScoreState>(
            builder: (context, state) {
              return PopupMenuButton(
                tooltip: '',
                enableFeedback: false,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                iconSize: 30,
                onSelected: (ButtonOption choice) => _action(choice, context, state),
                itemBuilder: (context) {
                  return <PopupMenuEntry<ButtonOption>>[
                    const PopupMenuItem(
                      value: ButtonOption.filter,
                      child: Text('Chọn học kỳ'),
                    ),
                    const PopupMenuItem(
                      value: ButtonOption.refresh,
                      child: Text('Làm mới'),
                    ),
                  ];
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _action(ButtonOption choice, BuildContext context, ScoreState state) {
    switch (choice) {
      case ButtonOption.filter:
        _filter(context, state);
        break;

      default:
        _refresh();
    }
  }

  void _filter(BuildContext rootContext, ScoreState state) async {
    await showDialog(
      context: rootContext,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _listTiles(rootContext, context, state.semester),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _listTiles(
    BuildContext rootContext,
    BuildContext dialogContext,
    Semester currentSemester,
  ) {
    List<Widget> tiles = [];

    semesters.forEach((semester) {
      tiles.add(InkWell(
        onTap: () {
          // rootContext.read<ScoreBloc>().add(ScoreSemesterChanged(rootContext, semester));
          Navigator.of(dialogContext).pop();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Radio<Semester>(
                value: semester,
                groupValue: currentSemester,
                onChanged: (_) => {},
              ),
              Text(semester.toString()),
            ],
          ),
        ),
      ));
    });

    return tiles;
  }

  void _refresh() {}
}
