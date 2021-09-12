import 'package:app_qldt/blocs/login/login_bloc.dart';
import 'package:app_qldt/constant/constant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, __, ___) => const LoginPage(),
      transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 1500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      constraints: const BoxConstraints.expand(),
      color: Colors.deepPurple,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(context),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () => _onWillPop(context, state),
              child: const Scaffold(
                resizeToAvoidBottomInset: false,
                body: HomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context, LoginState state) async {
    if (!state.hideLoginDialog) {
      context.read<LoginBloc>().add(const HideLoginDialog(true));
    }

    return Future.value(state.hideLoginDialog);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        BackScreen(),
        LoginForm(),
      ],
    );
  }
}

class BackScreen extends StatelessWidget {
  const BackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 1000),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstant.asset.loginBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (!context.read<LoginBloc>().state.status.isSubmissionInProgress) {
                context.read<LoginBloc>().add(const HideLoginDialog(true));
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                context.read<LoginBloc>().add(const HideLoginDialog(false));
              },
              child: Container(
                height: 60,
                margin: const EdgeInsets.all(32),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xfb40284a),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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
