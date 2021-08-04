import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:app_qldt/plan/plan.dart';

class InheritedScrollToPlanPage extends InheritedWidget {
  final PanelController panelController;

  const InheritedScrollToPlanPage({
    Key? key,
    required this.panelController,
    required Widget child,
  })  : assert(child is BlocProvider<PlanBloc>,
            'Child of InheritedScrollToPlanPage should be BlocProvider<PlanBloc>'),
        super(key: key, child: child);

  static InheritedScrollToPlanPage of(BuildContext context) {
    final InheritedScrollToPlanPage? result =
        context.dependOnInheritedWidgetOfExactType<InheritedScrollToPlanPage>();
    assert(result != null, 'No InheritedScrollToPlanPage found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(oldWidget) => false;
}
