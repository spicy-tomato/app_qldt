import 'package:app_qldt/_widgets/model/inherited_scroll_to_plan_page.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NavigablePlanPage extends StatelessWidget {
  final PanelController _panelController = PanelController();
  final Widget child;

  NavigablePlanPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedScrollToPlanPage(
      panelController: _panelController,
      child: BlocProvider<PlanBloc>(
        create: (_) => PlanBloc(),
        child: Stack(
          children: <Widget>[
            child,
            Slide(),
          ],
        ),
      ),
    );
  }
}

class Slide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PanelController panelController = InheritedScrollToPlanPage.of(context).panelController;

    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        return SlidingUpPanel(
          onPanelClosed: () {
            if (state.visibility != PlanPageVisibility.close) {
              context.read<PlanBloc>().add(PlanPageVisibilityChanged(PlanPageVisibility.close));
            }
          },
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height,
          controller: panelController,
          panelBuilder: (scrollController) {
            return PlanPage(scrollController: scrollController);
          },
        );
      },
    );
  }
}
