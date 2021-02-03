import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<LoginScreen> {
  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  var _userErr = "tài khoản không hợp lệ"; // check ch
  var _passErr = "tài khoản không hợp lệ"; //
  var _userInvalid = false;
  var _passInvalid = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                  // child: Image.asset('images/LogoUTC.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Text(
                  " LOGIN\n",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                    style: TextStyle(fontSize: 19, color: Colors.black),
                    controller: _userController,
                    decoration: InputDecoration(
                        labelText: "USERNAME",
                        errorText: _userInvalid ? _userErr : null,
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextField(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          controller: _passController,
                          obscureText: !_showPass,
                          decoration: InputDecoration(
                              labelText: "PASSWORD",
                              errorText: _passInvalid ? _passErr : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 15))),
                      GestureDetector(
                        onTap: showPassWord,
                        child: Text(
                          _showPass ? "HIDE" : "Show",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: (){
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text("LOGIN"),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "REMEMBER ME",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xff888888)),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "NEW USER ? LOGIN",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff888888)),
                      ),
                      Text(
                        "FORGOT PASSWORD?",
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showPassWord() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
