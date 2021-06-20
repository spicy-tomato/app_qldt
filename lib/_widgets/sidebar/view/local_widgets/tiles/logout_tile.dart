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
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
                content: Text('Bạn có muốn đăng xuất không?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                    },
                    child: Text('Có'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Không'),
                  ),
                ],
              ),
            );
          },
        );
}
