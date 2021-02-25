import 'package:app_qldt/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Appp extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Appp());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(builder: (context) {
              final userId = context.select(
                (AuthenticationBloc bloc) => bloc.state.user.id,
              );
              return Text('UserID: $userId');
            }),
            RaisedButton(
              child: const Text('Logout'),
              onPressed: () {
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
