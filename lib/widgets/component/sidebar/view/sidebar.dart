import 'package:app_qldt/blocs/authentication/authentication_bloc.dart';
import 'package:app_qldt/constant/constant.dart';
import 'package:app_qldt/screens/main/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_widgets/local_widgets.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstant.asset.sidebar),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            /// Close button
            Align(
              alignment: const Alignment(0.9, -0.95),
              child: IconButton(
                onPressed: _onCloseSidebar,
                icon: const SidebarIcon(Icons.close),
              ),
            ),
            Align(
              alignment: const Alignment(0.9, 0.95),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Setting button
                  IconButton(
                    icon: const SidebarIcon(Icons.settings),
                    onPressed: _onOpenSetting,
                  ),
                  const SizedBox(width: 10),

                  /// Logout button
                  IconButton(
                    icon: const SidebarIcon(Icons.exit_to_app_outlined),
                    onPressed: _onLogout,
                  )
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.7,
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const UserInfo(),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Flexible(
                          child: ScreenPageTilesList(),
                        ),
                        SizedBox(width: screenWidth * 0.15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCloseSidebar() async {
    await Navigator.maybePop(context);
  }

  Future<void> _onOpenSetting() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SettingPage(),
      ),
    );
  }

  Future<void> _onLogout() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
        content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
            },
            child: const Text('Có'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Không'),
          ),
        ],
      ),
    );
  }
}
