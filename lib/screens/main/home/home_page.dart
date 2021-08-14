import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/blocs/authentication/authentication_bloc.dart';
import 'package:app_qldt/blocs/plan/plan_bloc.dart';
import 'package:app_qldt/constant/constant.dart';
import 'package:app_qldt/widgets/component/bottom_note/bottom_note.dart';
import 'package:app_qldt/widgets/wrapper/navigable_plan_page.dart';
import 'package:app_qldt/widgets/wrapper/shared_ui.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return NavigablePlanPage(
      child: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          return SharedUI(
            onWillPop: () {
              if (!state.visibility.isClosed) {
                context.read<PlanBloc>().add(ClosePlanPage());
                return Future.value(false);
              }

              return Future.value(null);
            },
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeData.secondaryColor,
                  themeData.primaryColor,
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Greeting(),
                  Art(),
                  Quote(),
                  BottomNote(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;
    final userName = context.read<AuthenticationBloc>().state.user.name;
    final displayLetters = userName.split(' ');
    final letterNumbers = displayLetters.length;
    final displayName = displayLetters.length >= 2
        ? '${displayLetters[letterNumbers - 2]} ${displayLetters[letterNumbers - 1]}'
        : displayLetters[0];

    return Center(
      child: Text(
        'Xin chào\n$displayName',
        style: TextStyle(
          color: themeData.primaryTextColor,
          fontSize: 35,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Art extends StatelessWidget {
  const Art({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
        child: Image.asset(AppConstant.asset.homeAnimation),
      ),
    );
  }
}

class Quote extends StatelessWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Center(
      child: Text(
        'Chúc bạn\nmột ngày tốt lành!',
        style: TextStyle(
          color: themeData.primaryTextColor,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
