import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('Plan_page'),
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: SafeArea(
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
                  // Container(
                  //   height: 50,
                  //   padding: EdgeInsets.symmetric(horizontal: 60),
                  //   width: 200,
                  //   child: repeat(),
                  // ),
                ],
              ),
            ],
          ),
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
class Time extends StatefulWidget {
  @override
  _TimeState createState() => _TimeState();
}
class _TimeState extends State<Time> {
  late DateTime pickedDatef;
  late DateTime pickedDatel;
  late TimeOfDay timef;
  late TimeOfDay timel;
  @override
  void initState(){
    super.initState();
    pickedDatef=DateTime.now();
    pickedDatel=DateTime.now();
    timef = TimeOfDay.now();
    timel = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.access_time_rounded),
            title: Text('Cả ngày'),
            trailing: Switcher(),
          ),
          ListTile(
              // ignore: deprecated_member_use
              title:  RaisedButton(
                  child: Text("Stuff  ${pickedDatef.weekday+1}, ${DateFormat.yMMMd().format(pickedDatef)}"),
                  onPressed: ()  async{
                    DateTime datef = (await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDate:pickedDatef,
                    ))!;
                  if (datef != null) {
                    setState(() {
                        pickedDatef=datef;
                      });
                    }
                  }
              ),
              // ignore: deprecated_member_use
              trailing: RaisedButton(
                  child: Text(" ${timef.hour}:${timef.minute}"),
                  onPressed: () async{
                    TimeOfDay timefi = (await showTimePicker(
                      context: context,
                      initialTime: timef,
                    ))!;

                    if(timefi != null ){
                      setState(() {
                        timef=timefi;
                      });
                    }
                  }
              ),

          ),
          ListTile(
            // ignore: deprecated_member_use
            title:  RaisedButton(
                child: Text("Stuff  ${pickedDatel.weekday+1}, ${DateFormat.yMMMd().format(pickedDatel)}"),
                onPressed: ()  async{
                  DateTime datel = (await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate:pickedDatef,
                  ))!;
                  if(datel != null){
                    setState(() {
                      pickedDatel=datel;
                    });
                  }
                }
            ),
            // ignore: deprecated_member_use
            trailing: RaisedButton(
                child: Text(" ${timel.hour}:${timel.minute}"),
                onPressed: () async{
                  TimeOfDay timela = (await showTimePicker(
                    context: context,
                    initialTime: timef,
                  ))!;

                  if(timela != null ){
                    setState(() {
                      timel=timela;
                    });
                  }
                }
            ),

          ),
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
// class repeat extends StatefulWidget {
//   @override
//   _repeatState createState() => _repeatState();
// }
//
// // ignore: camel_case_types
// class _repeatState  extends State<repeat> {
//   late String value;
//   List _listitem = [
//     'không Lặp Lại',
//     'hàng Ngày','Hàng tuần'
//
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return CommonPadding(
//       child: DropdownButton(
//         value: value,
//         onChanged:(newValue){
//           setState(() {
//             value= newValue.toString();
//           });
//         },
//         items: _listitem.map((newValue){
//           return DropdownMenuItem(
//                value: newValue,
//               child: Text(newValue),
//           );
//         }).toList()
//       )
//
//     );
//   }
// }

