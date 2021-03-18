import 'package:app_qldt/_models/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_authentication/bloc/authentication_bloc.dart';
import 'package:app_qldt/sidebar/view/style/style.dart';
import 'package:app_qldt/_utils/const.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).backgroundColor,
                Color(0xff7579e7),
                Color(0xff9ab3f5),
              ],
            ),
          ),
          child: Stack(
            children: <Widget>[
              CloseButton(),
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
                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
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
                      child:
                          // BlocBuilder<ScreenBloc, ScreenState>(
                          //   builder: (context, state) {
                          //     return
                          ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                          // horizontal: 20,
                        ),
                        children: _getSidebarItems(context),
                      ),
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getSidebarItems(BuildContext context) {
    ScreenPage currentScreenPage = ScreenPage.login;
    String? currentRoute = ModalRoute.of(context)!.settings.name;

    for (var value in ScreenPage.values) {
      if (value.string == currentRoute) {
        currentScreenPage = value;
        break;
      }
    }

    List<Widget> _items = _getScreenPagesList(context, currentScreenPage);
    _items.add(_logoutTile(context, currentScreenPage));

    return _items;
  }

  List<Widget> _getScreenPagesList(BuildContext context, ScreenPage currentScreenPage) {
    Widget _firstListItem;

    if (currentScreenPage.index == 1) {
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
      ///  Chỉ số 0 là trang đăng nhập, vì thế bỏ qua trang này
      if (screenPage.index != 0) {
        if (screenPage.index == currentScreenPage.index) {
          _list.add(_CurrentScreenPageTile(screenPage: screenPage));
        } else if (screenPage.index == currentScreenPage.index - 1) {
          _list.add(_NextToAboveScreenPageTile(screenPage: screenPage));
        } else if (screenPage.index == currentScreenPage.index + 1) {
          _list.add(_NextToBelowScreenPageTile(screenPage: screenPage));
        } else {
          _list.add(_NormalScreenPageTile(screenPage: screenPage));
        }
      }
    }

    return _list;
  }

  Widget _logoutTile(BuildContext context, ScreenPage currentScreenPage) {
    if (currentScreenPage.index == ScreenPage.values.length - 1) {
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
          screenPage.name,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).backgroundColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () async {
          await Navigator.maybePop(context);
          // context.read<ScreenBloc>().add(ScreenPageChange(screenPage));
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
            screenPage.name,
            style: tileTextStyle(),
          ),
          onTap: () async {
            await Navigator.maybePop(context);

            Navigator.of(context).pushNamedAndRemoveUntil(screenPage.string, (route) => false);

            // context.read<ScreenBloc>().add(ScreenPageChange(screenPage));
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
            screenPage.name,
            style: tileTextStyle(),
          ),
          onTap: () async {
            await Navigator.of(context).maybePop();

            Navigator.of(context).pushNamedAndRemoveUntil(screenPage.string, (route) => false);

            // context.read<ScreenBloc>().add(ScreenPageChange(screenPage));
            // await Future.delayed(Duration(seconds: 2));
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
        screenPage.name,
        style: tileTextStyle(),
      ),
      onTap: () async {
        await Navigator.maybePop(context);

        Navigator.of(context).pushNamedAndRemoveUntil(screenPage.string, (route) => false);

        // context.read<ScreenBloc>().add(ScreenPageChange(screenPage));
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
            context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
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
            context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
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

class CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.9, -0.95),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () async => await Navigator.maybePop(context),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.close_rounded,
            color: Const.primaryColor,
          ),
        ),
      ),
    );
  }
}
