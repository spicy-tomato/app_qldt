import 'package:app_qldt/plan/view/local_widgets/local_widgets.dart';
import 'package:flutter/material.dart';

class AddGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddGuestTile(),
        ViewScheduleButton(),
      ],
    );
  }
}

class AddGuestTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlanPageCustomListTile(
      leading: const Icon(Icons.people),
      title: Text(
        'Thêm người',
        style: PlanPageConstant.of(context).hintTextFieldStyle,
      ),
      onTap: () {
        showGeneralDialog(
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 200),
          context: context,
          pageBuilder: (_, __, ___) {
            return AddGuestScreen();
          },
          transitionBuilder: (_, anim1, __, child) {
            return SlideTransition(
              position: Tween(
                begin: Offset(0, 0.4),
                end: Offset(0, 0),
              ).animate(anim1),
              child: child,
            );
          },
        );
      },
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
            child: Text(
              'Xem lịch biểu',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
              side: MaterialStateProperty.all(BorderSide(color: Colors.grey)),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            ),
          ),
        ),
      ),
    );
  }
}

class AddGuestScreen extends StatefulWidget {
  @override
  _AddGuestScreen createState() => _AddGuestScreen();
}

class _AddGuestScreen extends State<AddGuestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            PlanPageCustomListTile(
              title: TextField(),

            ),
          ],
        ),
      ),
    );
  }
}
