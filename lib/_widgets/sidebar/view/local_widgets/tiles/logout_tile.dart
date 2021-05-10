import 'package:app_qldt/_authentication/authentication.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen_page_tile.dart';

class LogoutTile extends ScreenPageTile {
  LogoutTile(BuildContext context, {Key? key, CustomPainter? painter})
      : super(
          key: key,
          painter: painter,
          onTap: () async {
            context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
          },
        );
}
