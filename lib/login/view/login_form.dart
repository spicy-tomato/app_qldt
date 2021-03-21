// // import 'package:app_qldt/login/view/local_widgets/style/fotter.dart';
// import 'package:flutter/material.dart';
//
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:formz/formz.dart';
//
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:app_qldt/login/login.dart';
//
// import 'local_widgets/local_widgets.dart';
// // import 'local_widgets/style/footer.dart';
//
// class LoginForm extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state.status.isSubmissionFailure) {
//           // Scaffold.of(context)
//           //   ..hideCurrentSnackBar()
//           //   ..showSnackBar(
//           //     const SnackBar(
//           //       content: Text('Authentication Failure'),
//           //     ),
//           //   );
//         }
//       },
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.end,
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//               child: SchoolLogo(),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//             margin: EdgeInsets.only(bottom: 20),
//             child: Text(
//               "UTC STUDENTS",
//               style:
//               TextStyle(color: Colors.blue , fontSize: 28,fontWeight: FontWeight.normal),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//             // padding: EdgeInsets.symmetric(horizontal: 32),
//             child: Center(
//               child: Image.asset("images/q.jpg", width: 150,
//                 height: 150,),
//             ),
//           ),
//
//           Container(
//             padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
//             margin: EdgeInsets.only(bottom: 20),
//             child: Text(
//               "university of transport and communications",
//               textAlign: TextAlign.center,
//               style:
//               TextStyle(  fontSize: 26,fontWeight: FontWeight.w600),
//             ),
//           ),
//
//           Container(
//             padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
//             child: GestureDetector(
//               onTap: () {
//
//               },
//               child: Container(
//                 margin: EdgeInsets.all(32),
//                 padding: EdgeInsets.all(20),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Color(0xFFB40284A),
//                     borderRadius: BorderRadius.circular(50)),
//                 child: Center(
//                   child: Text(
//                     "Get Started",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//           )
//
//           // Padding(
//           //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//           //   child: const Text(
//           //     " UTC LOGIN\n",
//           //     style: TextStyle(
//           //         fontWeight: FontWeight.bold,
//           //         color: Colors.blue,
//           //         fontSize: 30),
//           //   ),
//           // ),
//
//         ],
//       ),
//     );
//   }
//
//
// }
// import 'package:app_qldt/login/view/local_widgets/style/fotter.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:formz/formz.dart';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:app_qldt/login/login.dart';
// import 'package:keyboard_visibility/keyboard_visibility.dart';

// import '../login_button.dart';
// import '../password_input.dart';
// import '../school_logo.dart';
// import '../username_input.dart';




class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child:HomeScreen() ,
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
  double _registerYOffset = 0;
  double _registerHeight = 0;

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
    _registerHeight = windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 120 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
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
                            TextStyle(color: _headingColor, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Image.asset("images/q.jpg", width: 150,
                      height: 150,),
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
                          color: Colors.redAccent,
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
                  InputWithIcon(
                    icon: Icons.lock,
                    hint: "MSV.....",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWithIcon(
                    icon: Icons.vpn_key,
                    hint: " Password...",
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  PrimaryButton(
                    btnText: "Login",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 2;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Forgot password",
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({required this.icon, required this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  int a = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextField(
              decoration: InputDecoration(

                labelText:  'Mã sinh viên',
                errorText:
                a<0 ? 'Hãy nhập mã sinh viên' : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({required this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFB40284A), borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({required this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFB40284A), width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 16),
        ),
      ),

    );
  }
}

