import 'package:app_qldt/plan/view/local_widgets/local_widgets.dart';
import 'package:flutter/material.dart';

class AddPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonPadding(
      child: Column(
        children: <Widget>[
          AddPeopleTile(),
          ViewScheduleButton(),
        ],
      ),
    );
  }
}

class AddPeopleTile extends StatefulWidget {
  @override
  _AddPeopleTileState createState() => _AddPeopleTileState();
}

class _AddPeopleTileState extends State<AddPeopleTile> {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      leading: const Icon(Icons.people),
      title: TextField(
        style: PlanPageConstant.of(context).textFieldStyle,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Thêm người',
            hintStyle: PlanPageConstant.of(context).hintTextFieldStyle),
      ),
    );
  }
}

class ViewScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      title: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton(
            onPressed: () {
              print('Xem lịch biểu');
            },
            child: Text('Xem lịch biểu',
                style:
                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
              side: MaterialStateProperty.all(BorderSide(color: Theme.of(context).primaryColor)),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            ),
          ),
        ),
      ),
    );
  }
}
