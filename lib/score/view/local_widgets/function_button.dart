import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_widgets/wrapper/hide_tooltip.dart';
import 'package:app_qldt/score/bloc/score_bloc.dart';
import 'package:app_qldt/_models/semester_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ButtonOption {
  filter,
  refresh,
}

class FunctionButton extends StatefulWidget {
  const FunctionButton({Key? key}) : super(key: key);

  @override
  _FunctionButtonState createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  late List<SemesterModel> semesters;

  @override
  Widget build(BuildContext context) {
    semesters = context.read<UserRepository>().userDataModel.scoreServiceController.semester;

    return HideTooltip(
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
                icon: const Icon(
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
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _listTiles(rootContext, context, state.semester),
          ),
        );
      },
    );
  }

  List<Widget> _listTiles(
    BuildContext rootContext,
    BuildContext dialogContext,
    SemesterModel currentSemester,
  ) {
    List<Widget> tiles = [];

    for (var semester in semesters) {
      tiles.add(InkWell(
        onTap: () {
          // rootContext.read<ScoreBloc>().add(ScoreSemesterChanged(rootContext, semester));
          Navigator.of(dialogContext).pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Radio<SemesterModel>(
                value: semester,
                groupValue: currentSemester,
                onChanged: (_) => {},
              ),
              Text(semester.toString()),
            ],
          ),
        ),
      ));
    }

    return tiles;
  }

  void _refresh() {}
}
