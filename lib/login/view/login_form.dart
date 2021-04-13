// import 'package:app_qldt/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_librvary_into_null_safe, import_of_legacy_library_into_null_safe
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'local_widgets/login_button.dart';
import 'local_widgets/password_input.dart';
// import 'local_widgets/style/form_text_style.dart';
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
          child: HomeScreen() ,
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
  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  // double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
          print("Keyboard State Changed : $visible");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    // _registerHeight = windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.blueAccent;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 220;

        _loginXOffset = 0;
        break;
      case 1:
        _backgroundColor = Colors.deepPurple;
        _headingColor = Colors.white;

        _headingTop = 90;

        _loginWidth = windowWidth ;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 150 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 220;

        _loginXOffset = 0;
        break;
    // case 2:
    //   _backgroundColor = Color(0xFFBD34C59);
    //   _headingColor = Colors.white;
    //
    //   _headingTop = 80;
    //
    //   _loginWidth = windowWidth - 40;
    //   _loginOpacity = 0.7;
    //
    //   _loginYOffset = _keyboardVisible ? 30 : 20;
    //   _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;
    //
    //   _loginXOffset = 20;
    //   _registerYOffset = _keyboardVisible ? 55 : 270;
    //   _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
    //   break;
    }

    return Stack(
      children: <Widget>[
        AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            color: _backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 0;
                    });
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AnimatedContainer(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(milliseconds: 1000),
                          margin: EdgeInsets.only(
                            top: _headingTop,
                          ),
                          child: Text(
                            "UTC STUDENTS",
                            style:
                            TextStyle(color: _headingColor, fontSize: 28),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "university of transport and communications",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Image.asset("images/splash_bg.png", width: 300,
                      height: 300,),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_pageState != 0) {
                          _pageState = 0;
                        } else {
                          _pageState = 1;
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(32),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFB40284A),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
        AnimatedContainer(
          padding: EdgeInsets.all(32),
          width: _loginWidth,
          height: _loginHeight,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(_loginOpacity),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Login To Continue",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  UsernameInput(

                  ),
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
        ),

      ],
    );
  }
}



