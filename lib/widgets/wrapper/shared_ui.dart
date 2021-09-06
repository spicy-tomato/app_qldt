import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/widgets/component/sidebar/sidebar.dart';
import 'package:app_qldt/widgets/component/topbar/topbar.dart';

class SharedUI extends StatelessWidget {
  final Widget child;
  final Widget? topRightWidget;
  final BoxDecoration? decoration;
  final Color? topbarColor;
  final Color? topbarIconColor;
  final bool? stable;
  final Future<bool?> Function()? onWillPop;
  final Function()? beforeOpenSidebar;

  const SharedUI({
    Key? key,
    required this.child,
    this.decoration,
    this.topRightWidget,
    this.topbarColor,
    this.topbarIconColor,
    this.stable,
    this.onWillPop,
    this.beforeOpenSidebar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeData.primaryColor,
      drawer: const Sidebar(),
      body: Container(
        decoration: decoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TopBar(
              topRightWidget: topRightWidget,
              backgroundColor: topbarColor,
              iconColor: topbarIconColor,
              stable: stable ?? true,
              beforeOpenSidebar: beforeOpenSidebar,
            ),
            Expanded(
              child: WillPopScope(
                onWillPop: () async {
                  if (onWillPop != null) {
                    final bool? pop = await onWillPop!.call();
                    if (pop != null) {
                      return Future.value(pop);
                    }
                  }

                  return _onWillPop(context);
                },
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (Navigator.of(context).canPop()) {
      return Future.value(true);
    }

    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Bạn có chắc chắn muốn thoát ứng dụng không?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Có'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Không'),
                ),
              ],
            );
          },
        ) ??
        Future.value(false);
  }
}
