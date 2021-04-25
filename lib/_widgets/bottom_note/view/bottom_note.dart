import 'package:flutter/material.dart';
import 'package:app_qldt/plan/plan.dart';

class BottomNote extends StatelessWidget {
  const BottomNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Stack(
        children: <Widget>[
          BottomText(),
          AddNoteButton(),
        ],
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff26153B),
        ),
        child: TextButton(
          onPressed: () {
            showGeneralDialog(
              barrierDismissible: false,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 200),
              context: context,
              pageBuilder: (_, __, ___) {
                return PlanPage();
              },
              transitionBuilder: (_, anim1, __, child) {
                return SlideTransition(
                  position: Tween(
                    begin: Offset(0, 1),
                    end: Offset(0, 0),
                  ).animate(anim1),
                  child: child,
                );
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bạn có dự định gì không?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff85749C),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Material(
          shape: addNoteButtonShape(),
          color: Color(0xff694A85),
          child: InkWell(
            customBorder: addNoteButtonShape(),
            onTap: () {
              print("Button pressed!");
            },
            child: Align(
              alignment: Alignment(-0.7, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Thêm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder addNoteButtonShape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ),
    );
  }
}
