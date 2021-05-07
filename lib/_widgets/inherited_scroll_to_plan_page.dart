import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class InheritedScrollToPlanPage extends InheritedWidget {
  final PanelController panelController;

  InheritedScrollToPlanPage({
    Key? key,
    required this.panelController,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritedScrollToPlanPage of(BuildContext context) {
    final InheritedScrollToPlanPage? result =
        context.dependOnInheritedWidgetOfExactType<InheritedScrollToPlanPage>();
    assert(result != null, 'No InheritedScrollToPlanPage found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
