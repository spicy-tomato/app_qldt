import 'package:app_qldt/authentication/bloc/authentication_bloc.dart';
import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:app_qldt/utils/const.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Const.sideBarBackgroundColor,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BlocBuilder<SidebarBloc, SidebarState>(
              builder: (context, state) {
                return ListTile(
                  trailing: const Icon(Icons.close),
                  onTap: () {
                    context.read<SidebarBloc>().add(SidebarCloseRequested());
                  },
                );
              },
            ),
            UserAccountsDrawerHeader(
                accountName: const Text("MSV:191203380"),
                accountEmail: const Text("trantambcd@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: Row(
                    children: [Image.asset('images/avatar.jpg')],
                  ),
                )),
            ListTile(
                title: const Text('HOME'),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
                title: const Text('Today'),
                onTap: () {
                  Navigator.pop(context, '/feature/');
                }),
            ListTile(
                title: const Text('Firebase'),
                onTap: () {
                  Navigator.pop(context, '/firebase');
                }),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                // final prefs = await SharedPreferences.getInstance();
                // prefs.remove('student_id');
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}
