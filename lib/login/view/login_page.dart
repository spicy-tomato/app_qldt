import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_repositories/authentication_repository/authentication_repository.dart';
import 'package:app_qldt/login/bloc/login_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, __, ___) => LoginPage(),
      transitionsBuilder: (context, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: Duration(milliseconds: 1500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      constraints: const BoxConstraints.expand(),
      color: Colors.deepPurple,
      child: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () => _onWillPop(context, state),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  child: HomeScreen(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context, LoginState state) async {
    if (!state.hideLoginDialog) {
      context.read<LoginBloc>().add(HideLoginDialog(true));
    }

    return Future.value(state.hideLoginDialog);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        context.read<LoginBloc>().add(HideKeyboard(!visible));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackScreen(),
        LoginForm(),
      ],
    );
  }
}

class BackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/backgr.gif"),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              context.read<LoginBloc>().add(HideLoginDialog(true));
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  context.read<LoginBloc>().add(HideLoginDialog(false));
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFB40284A),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
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
