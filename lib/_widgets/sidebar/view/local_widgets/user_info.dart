import 'package:app_qldt/_authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
    );
  }
}
