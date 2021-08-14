import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/enums/config/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenPageTile extends StatelessWidget {
  final ScreenPage? screenPage;
  final bool? current;
  final bool? empty;
  final CustomPainter? painter;
  final Function()? onTap;

  final TextStyle tileTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  const ScreenPageTile({
    Key? key,
    this.screenPage,
    this.current,
    this.empty,
    this.painter,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    return CustomPaint(
      painter: painter,
      child: Container(
        decoration: current != null && current!
            ? BoxDecoration(
                color: themeData.primaryTextColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              )
            : null,
        child: empty == null || !empty!
            ? ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: screenPage != null
                      ? Text(
                          screenPage!.name,
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                current != null && current! ? themeData.secondaryTextColor : themeData.primaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Container(),
                ),
                onTap: onTap,
              )
            : Container(height: 56),
      ),
    );
  }
}
