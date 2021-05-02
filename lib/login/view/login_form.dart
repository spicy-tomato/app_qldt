import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'local_widgets/login_button.dart';
import 'local_widgets/password_input.dart';
import 'local_widgets/username_input.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: HomeScreen(),
        ),
      ),
    );
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/backgr.gif"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
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
        ),
        BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text("Thông tin"),
                    content: Text("Đăng nhập thất bại"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
                        child: const Text("Đồng ý"),
                      )
                    ],
                  );
                },
              );
            }
          },
          buildWhen: (previous, current) =>
              previous.hideLoginDialog != current.hideLoginDialog ||
              previous.hideKeyboard != current.hideKeyboard,
          builder: (context, state) {
            return AnimatedContainer(
              padding: const EdgeInsets.all(32),
              width: screenWidth,
              height: screenHeight,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(
                  0,
                  state.hideLoginDialog
                      ? 750
                      : state.hideKeyboard
                          ? 270
                          : 170,
                  1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          "Đăng nhập để tiếp tục",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      UsernameInput(),
                      SizedBox(
                        height: 20,
                      ),
                      PasswordInput(),
                      SizedBox(
                        height: 20,
                      ),
                      LoginButton(),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: GestureDetector(
          onTap: () {
            // setState(() {
            //   _loginDialogIsOpen = !_loginDialogIsOpen;
            // });
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
                "Bắt đầu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
