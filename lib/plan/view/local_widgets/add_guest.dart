import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_widgets/list_tile/custom_list_tile.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:app_qldt/plan/view/local_widgets/local_widgets.dart';

class AddGuest extends StatelessWidget {
  const AddGuest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        AddGuestTile(),
        ViewScheduleButton(),
      ],
    );
  }
}

class AddGuestTile extends StatelessWidget {
  const AddGuestTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      disabled: context.read<PlanBloc>().state.type.isEditSchedule,
      leading: const Icon(Icons.people_alt_outlined),
      title: Text(
        'Thêm người',
        style: PlanPageConstant.hintTextFieldStyle,
      ),
      onTap: () {
        showGeneralDialog(
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 200),
          context: context,
          pageBuilder: (_, __, ___) {
            return const AddGuestScreen();
          },
          transitionBuilder: (_, anim1, __, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.4),
                end: const Offset(0, 0),
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
  const ViewScheduleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: OutlinedButton(
          onPressed: () {
            // print('Xem lịch biểu');
          },
          child: Text(
            'Xem lịch biểu',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 20),
            ),
            side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Colors.grey)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          ),
        ),
      ),
    );
  }
}

class AddGuestScreen extends StatefulWidget {
  const AddGuestScreen({Key? key}) : super(key: key);

  @override
  _AddGuestScreen createState() => _AddGuestScreen();
}

class _AddGuestScreen extends State<AddGuestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            CustomListTile(
              title: TextField(),
            ),
          ],
        ),
      ),
    );
  }
}
