import 'dart:math';

import 'package:app_qldt/login/view/local_widgets/local_widgets.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> with TickerProviderStateMixin {
  // final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final cardPadding = 16.0;
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);

    return FittedBox(
      child: Card(
        elevation: 0,
        child: Form(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: cardPadding,
                    right: cardPadding,
                    top: cardPadding + 10),
                width: cardWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UsernameInput(),
                    SizedBox(height: 20),
                    PasswordInput(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: cardPadding,
                  right: cardPadding,
                  top: cardPadding,
                ),
                child: LoginButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
