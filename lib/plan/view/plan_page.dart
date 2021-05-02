import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('Plan_page'),
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 40,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            SizedBox(height: 20),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                PlanPageTopbar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Title(),
                ),
                PlanPageDivider(context: context),
                Time(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle addTitleTextStyle() {
  return TextStyle(
    fontSize: 25,
  );
}

class CommonPadding extends Padding {
  CommonPadding({required Widget child})
      : super(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: child,
        );
}

class PlanPageDivider extends Divider {
  PlanPageDivider({required BuildContext context})
      : super(
          color: Theme.of(context).backgroundColor,
        );
}

class PlanPageTopbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Icon(
              Icons.close,
              color: Theme.of(context).backgroundColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Container(
            width: 80,
            height: 40,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Theme.of(context).backgroundColor,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () {
                  print('Save button pressed!');
                },
                child: Center(
                  child: Text('Lưu'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: addTitleTextStyle(),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Thêm tiêu đề',
        hintStyle: addTitleTextStyle(),
      ),
    );
  }
}

class Time extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonPadding(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.access_time_rounded),
            title: Text('Cả ngày'),
            trailing: Switcher(),
          ),
          ListTile(
            title: Text(DateFormat.yMMMd().format(DateTime.now())),
            trailing: Text(
              '20:00',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
          ListTile(
            title: Text(DateFormat.yMMMd().format(DateTime.now())),
            trailing: Text(
              '20:00',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Switcher extends StatefulWidget {
  final bool? initState;

  Switcher({this.initState});

  @override
  _SwitcherState createState() => _SwitcherState(initState);
}

class _SwitcherState extends State<Switcher> {
  late bool isOn;

  _SwitcherState(bool? isOn) {
    this.isOn = isOn ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isOn,
      onChanged: toggleSwitch,
    );
  }

  void toggleSwitch(_) {
    setState(() {
      isOn = !isOn;
    });
  }
}
