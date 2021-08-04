import 'package:app_qldt/_authentication/authentication.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_widgets/sidebar/avatar_bloc/avatar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'avatar_fullscreen.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    final avatarPath = context.read<UserRepository>().userDataModel.avatarPath;

    return Column(
      children: <Widget>[
        BlocProvider<AvatarBloc>(
          create: (context) => AvatarBloc(context, avatarPath),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              BlocBuilder<AvatarBloc, AvatarState>(
                buildWhen: (previous, current) => previous.file != current.file,
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => _viewAvatar(state),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      child: Center(
                        child: Container(
                          width: 112,
                          height: 112,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                          ),
                          child: state.file.existsSync()
                              ? Image.file(
                                  state.file,
                                  key: UniqueKey(),
                                )
                              : Center(
                                  child: Text(
                                    user.name.split(' ').last[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 60,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: -6,
                bottom: -6,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: BlocBuilder<AvatarBloc, AvatarState>(
                    builder: (context, state) {
                      return IconButton(
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () => context.read<AvatarBloc>().add(PickAvatarEvent()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          user.name,
          maxLines: 2,
        ),
        const SizedBox(height: 10),
        Text(user.id),
      ],
    );
  }

  void _viewAvatar(AvatarState state) {
    if (state.file.existsSync()) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) {
          return AvatarFullScreen(image: state.file);
        }),
      );
    }
  }
}
