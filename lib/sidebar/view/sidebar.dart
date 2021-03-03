import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/authentication/bloc/authentication_bloc.dart';
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
          color: Const.sideBarBackgroundColor,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: screenWidth * 0.1,
              right: screenWidth * 0.1,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: BlocBuilder<SidebarBloc, SidebarState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(Icons.close_rounded),
                      color: Const.primaryColor,
                      onPressed: () {
                        context
                            .read<SidebarBloc>()
                            .add(SidebarCloseRequested());
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
                    }),
                  ),
                  Flexible(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 20,
                      ),
                      children: <Widget>[
                        ListTile(
                          title: const Text('HOME'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Today'),
                          onTap: () {
                            Navigator.pop(context, '/feature/');
                          },
                        ),
                        ListTile(
                          title: const Text('Firebase'),
                          onTap: () {
                            Navigator.pop(context, '/firebase');
                          },
                        ),
                        ListTile(
                          title: const Text('Logout'),
                          onTap: () async {
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationLogoutRequested());
                          },
                        ),
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
}

class UserImageClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(30, 30, 100, 100);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
