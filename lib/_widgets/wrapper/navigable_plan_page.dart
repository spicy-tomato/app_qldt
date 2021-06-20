import 'package:app_qldt/_widgets/model/inherited_scroll_to_plan_page.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NavigablePlanPage extends StatelessWidget {
  final PanelController _panelController = PanelController();
  final Widget child;
  final Function()? onPanelClose;

  NavigablePlanPage({
    Key? key,
    required this.child,
    this.onPanelClose,
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
            Slide(
              onPanelClose: onPanelClose,
              panelController: _panelController,
            ),
          ],
        ),
      ),
    );
  }
}

class Slide extends StatefulWidget {
  final Function()? onPanelClose;
  final PanelController panelController;

  const Slide({
    Key? key,
    required this.onPanelClose,
    required this.panelController,
  }) : super(key: key);

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        return SlidingUpPanel(
          onPanelClosed: () => _onPanelClosed(state),
          onPanelSlide: (position) => _onPanelSlide(position, state),
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height,
          controller: widget.panelController,
          panelBuilder: (scrollController) {
            return PlanPage(
              scrollController: scrollController,
              onCloseButtonTap: widget.onPanelClose,
            );
          },
        );
      },
    );
  }

  void _onPanelClosed(PlanState state) {
    if (state.visibility != PlanPageVisibility.close) {
      context.read<PlanBloc>().add(ClosePlanPage());
      if (widget.onPanelClose != null) {
        widget.onPanelClose!.call();
      }
    }
  }

  void _onPanelSlide(double position, PlanState state) {
    if (position > 0.31 && state.visibility == PlanPageVisibility.apart) {
      context.read<PlanBloc>().add(OpenPlanPage());
    }
  }
}
