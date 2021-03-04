import 'package:app_qldt/models/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/authentication/bloc/authentication_bloc.dart';
import 'package:app_qldt/sidebar/view/style/style.dart';
import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/utils/const.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Const.sideBarBackgroundColor, Const.calendarMarkerColor],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: BlocBuilder<ScreenBloc, ScreenState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(Icons.close_rounded),
                      color: Const.primaryColor,
                      onPressed: () {
                        // context
                        //     .read<SidebarBloc>()
                        //     .add(SidebarCloseRequested());
                        Navigator.maybePop(context);
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: screenWidth * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return Column(
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 4,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                image: const DecorationImage(
                                  image: ExactAssetImage('images/avatar.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(state.user.name.toString()),
                            const SizedBox(height: 10),
                            Text(state.user.id.toString()),
                          ],
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: BlocBuilder<ScreenBloc, ScreenState>(
                      builder: (context, state) {
                        return ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            // horizontal: 20,
                          ),
                          children: _getSidebarItems(context, state),
                        );
                      },
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

  List<Widget> _getSidebarItems(BuildContext context, ScreenState state) {
    List<Widget> _items = _getScreenPagesList(context, state);
    _items.add(_logoutTile(context, state));

    return _items;
  }

  List<Widget> _getScreenPagesList(BuildContext context, ScreenState state) {
    Widget _firstListItem;

    if (state.screenPage.index == 0) {
      _firstListItem = CustomPaint(
        painter: _PainterForAbove(context),
        child: Container(
          height: 56,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
      );
    } else {
      _firstListItem = Container(
        height: 56,
      );
    }

    List<Widget> _list = [_firstListItem];

    for (var screenPage in ScreenPage.values) {
      if (screenPage.index == state.screenPage.index) {
        _list.add(_CurrentScreenPageTile(screenPage: screenPage));
      } else if (screenPage.index == state.screenPage.index - 1) {
        _list.add(_NextToAboveScreenPageTile(screenPage: screenPage));
      } else if (screenPage.index == state.screenPage.index + 1) {
        _list.add(_NextToBelowScreenPageTile(screenPage: screenPage));
      } else {
        _list.add(_NormalScreenPageTile(screenPage: screenPage));
      }
    }

    return _list;
  }

  Widget _logoutTile(BuildContext context, ScreenState state) {
    if (state.screenPage.index == ScreenPage.values.length - 1) {
      return _NextToLogoutTile();
    }

    return _NormalLogoutTile();
  }
}

class _CurrentScreenPageTile extends StatelessWidget {
  final ScreenPage screenPage;

  const _CurrentScreenPageTile({
    Key? key,
    required this.screenPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: ListTile(
        title: Text(
          screenPage.string,
          style: tileTextStyle(),
        ),
        onTap: () {
          Navigator.maybePop(context);
          context.read<ScreenBloc>().add(ScreenPageChange(screenPage));
        },
      ),
    );
  }
}

class _NextToAboveScreenPageTile extends StatelessWidget {
  final ScreenPage screenPage;

  const _NextToAboveScreenPageTile({
    Key? key,
    required this.screenPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PainterForAbove(context),
      child: Container(
        child: ListTile(
          title: Text(
            screenPage.string,
            style: tileTextStyle(),
          ),
          onTap: () {
            Navigator.maybePop(context);
            context
                .read<ScreenBloc>()
                .add(ScreenPageChange(screenPage));
          },
        ),
      ),
    );
  }
}

class _NextToBelowScreenPageTile extends StatelessWidget {
  final ScreenPage screenPage;

  const _NextToBelowScreenPageTile({
    Key? key,
    required this.screenPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PainterForBelow(context),
      child: Container(
        child: ListTile(
          title: Text(
            screenPage.string,
            style: tileTextStyle(),
          ),
          onTap: () {
            Navigator.maybePop(context);
            context
                .read<ScreenBloc>()
                .add(ScreenPageChange(screenPage));
          },
        ),
      ),
    );
  }
}

class _NormalScreenPageTile extends StatelessWidget {
  final ScreenPage screenPage;

  const _NormalScreenPageTile({
    Key? key,
    required this.screenPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        screenPage.string,
        style: tileTextStyle(),
      ),
      onTap: () {
        Navigator.maybePop(context);
        context.read<ScreenBloc>().add(ScreenPageChange(screenPage));
      },
    );
  }
}

class _NextToLogoutTile extends StatelessWidget {
  const _NextToLogoutTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PainterForBelow(context),
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          // color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
          ),
        ),
        child: ListTile(
          title: Text(
            'Đăng xuất',
            style: tileTextStyle(),
          ),
          onTap: () async {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested());
          },
        ),
      ),
    );
  }
}

class _NormalLogoutTile extends StatelessWidget {
  const _NormalLogoutTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            'Đăng xuất',
            style: tileTextStyle(),
          ),
          onTap: () async {
            print(state.status);
            print(state.user);
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested());
          },
        );
      },
    );
  }
}

class _PainterForAbove extends CustomPainter {
  final BuildContext context;

  _PainterForAbove(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.color = Colors.white;

    path.moveTo(38, 56);
    path.cubicTo(-18, 56, 0, 0, 0, 56);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PainterForBelow extends CustomPainter {
  final BuildContext context;

  _PainterForBelow(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.color = Colors.white;

    path.moveTo(38, 0);
    path.cubicTo(-18, 0, 0, 56, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
