import 'package:app_qldt/_widgets/inherited_scroll_to_plan_page.dart';
import 'package:flutter/material.dart';

class PlanPageTopbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () => InheritedScrollToPlanPage.of(context).panelController.close(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Icon(
              Icons.close,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Container(
            width: 80,
            height: 40,
            child: Material(
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                onTap: () {
                  print('Save button pressed!');
                },
                child: const Center(
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
