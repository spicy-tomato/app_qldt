import 'package:app_qldt/_utils/helper/day_of_week_vn.dart';
import 'package:app_qldt/blocs/plan/plan_bloc.dart';
import 'package:app_qldt/constant/constant.dart';
import 'package:app_qldt/widgets/component/list_tile/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_widgets/local_widgets.dart';

class PlanPage extends StatefulWidget {
  final ScrollController scrollController;
  final Function()? onCloseButtonTap;

  const PlanPage({
    Key? key,
    required this.scrollController,
    this.onCloseButtonTap,
  }) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlanBloc, PlanState>(
        buildWhen: (previous, current) =>
            previous.fromDay != current.fromDay || previous.visibility != current.visibility,
        builder: (context, state) {
          if (state.visibility.isOpened) {
            return _FullPlanPage(
              onCloseButtonTap: widget.onCloseButtonTap,
              scrollController: widget.scrollController,
            );
          }

          return _ApartPlanPage(onCloseButtonTap: widget.onCloseButtonTap);
        },
      ),
    );
  }
}

class _FullPlanPage extends StatefulWidget {
  final ScrollController scrollController;
  final Function()? onCloseButtonTap;

  const _FullPlanPage({
    Key? key,
    required this.scrollController,
    this.onCloseButtonTap,
  }) : super(key: key);

  @override
  _FullPlanPageState createState() => _FullPlanPageState();
}

class _FullPlanPageState extends State<_FullPlanPage> {
  @override
  Widget build(BuildContext contexts) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                AppConstant.asset.swipeDownIcon,
                width: 40,
              ),
            ),
            PlanPageTopbar(onCloseButtonTap: widget.onCloseButtonTap),
          ],
        ),
        Expanded(
          child: ListView(
            controller: widget.scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              const PlanPageTitle(),
              PlanPageDivider(context: context),
              const PlanPageTime(),
              PlanPageDivider(context: context),
              // AddGuest(),
              // PlanPageDivider(context: context),
              const Location(),
              PlanPageDivider(context: context),
              const Describe(),
              PlanPageDivider(context: context),
              // Accessibility(),
              // PlanPageDivider(context: context),
              // Status(),
              // PlanPageDivider(context: context),
              const PlanColor(),
              PlanPageDivider(context: context),
            ],
          ),
        ),
      ],
    );
  }
}

class _ApartPlanPage extends StatefulWidget {
  final Function()? onCloseButtonTap;

  const _ApartPlanPage({
    Key? key,
    this.onCloseButtonTap,
  }) : super(key: key);

  @override
  __ApartPlanPageState createState() => __ApartPlanPageState();
}

class __ApartPlanPageState extends State<_ApartPlanPage> {
  late DateTime _fromDay;
  late DateTime _toDay;

  @override
  void initState() {
    super.initState();
    _fromDay = context.read<PlanBloc>().state.fromDay;
    _toDay = context.read<PlanBloc>().state.toDay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _onTap,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Image.asset(
                AppConstant.asset.minimizeIcon,
                width: 80,
              ),
            ),
            PlanPageTopbar(onCloseButtonTap: widget.onCloseButtonTap),
            CustomListTile(
              title: Text(
                'Thêm tiêu đề',
                style: PlanPageConstant.hintTextFieldStyle.copyWith(fontSize: 25),
              ),
              defaultHeight: false,
            ),
            CustomListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  '${DayOfWeekVN.get(_fromDay.weekday)}, '
                  'ngày ${_fromDay.day} '
                  'tháng ${_fromDay.month} · '
                  '${_fromDay.hour}:00 - '
                  '${_toDay.hour}:00',
                  style: PlanPageConstant.textFieldStyle,
                ),
              ),
              defaultHeight: false,
            ),
            CustomListTile(
              leading: const Icon(Icons.people_alt_outlined),
              title: Text(
                'Thêm người',
                style: PlanPageConstant.hintTextFieldStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    context.read<PlanBloc>().add(const OpenPlanPage());
  }
}
