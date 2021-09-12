import 'package:app_qldt/blocs/login/login_bloc.dart';
import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:formz/formz.dart';

import 'local_widgets/local_widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late bool showLoginFailedDialog;

  TextStyle get _titleTextStyle => const TextStyle(
        fontSize: 20,
        color: Colors.black,
        height: 1.2,
      );

  @override
  void initState() {
    super.initState();
    showLoginFailedDialog = false;
  }

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode focusNode = FocusScope.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<LoginBloc, LoginState>(
      listener: _showDialogListener,
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) {
          return previous.hideLoginDialog != current.hideLoginDialog;
        },
        builder: (_, state) {
          return KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return AnimatedContainer(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 18,
                ),
                width: screenWidth,
                height: screenHeight,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 1000),
                transform: Matrix4.translationValues(
                    0,
                    state.hideLoginDialog
                        ? screenHeight
                        : isKeyboardVisible
                            ? 170
                            : 270,
                    1),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 50,
                            child: BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) => previous.accountPermission != current.accountPermission,
                              builder: (context, state) {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: state.accountPermission.isUser
                                      ? Text(
                                          'Đăng nhập để tiếp tục',
                                          key: const ValueKey(0),
                                          style: _titleTextStyle,
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          'Đăng nhập với tài khoản\n Quản lý đào tạo',
                                          key: const ValueKey(1),
                                          style: _titleTextStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                );
                              },
                            ),
                          ),
                        ),
                        UsernameInput(focusNode: focusNode),
                        const SizedBox(height: 20),
                        PasswordInput(focusNode: focusNode),
                        const SizedBox(height: 20),
                        LoginButton(focusNode),
                        const SizedBox(height: 40),
                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) =>
                              previous.accountPermission != current.accountPermission || previous.status != current.status,
                          builder: (context, state) => Column(
                            children: <Widget>[
                              if (state.accountPermission.isUser || state.status.isSubmissionInProgress)
                                Container()
                              else
                                _loginAnchor,

                              if (state.accountPermission.isGuest || state.status.isSubmissionInProgress)
                                Container()
                              else
                                _loginAsGuestAnchor,
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showDialogListener(BuildContext context, LoginState state) async {
    if (state.status.isSubmissionFailure && !showLoginFailedDialog && state.shouldShowLoginFailedDialog) {
      showLoginFailedDialog = true;
      context.read<LoginBloc>().add(ShowedLoginFailedDialog());
      await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => _loginFailedDialog(context),
      );
    }
  }

  Widget get _loginAnchor => Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: GestureDetector(
          onTap: () => _switchToLoginForm(context),
          child: const Text(
            'Đăng nhập với tài khoản đã xác minh',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              color: Colors.blueAccent,
            ),
          ),
        ),
      );

  Widget get _loginAsGuestAnchor => Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: GestureDetector(
          onTap: () => _switchToLoginAsGuestForm(context),
          child: const Text(
            'Đăng nhập với tài khoản\nQuản lý đào tạo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              color: Colors.blueAccent,
            ),
          ),
        ),
      );

  Widget _loginFailedDialog(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: AlertDialog(
        title: const Text('Thông tin'),
        content: const Text('Đăng nhập thất bại'),
        actions: [
          TextButton(
            onPressed: () {
              showLoginFailedDialog = false;
              Navigator.of(context).pop();
            },
            child: const Text('Đồng ý'),
          )
        ],
      ),
    );
  }

  void _switchToLoginForm(BuildContext context) {
    context.read<LoginBloc>().add(const FormTypeChanged(AccountPermission.user));
  }

  void _switchToLoginAsGuestForm(BuildContext context) {
    context.read<LoginBloc>().add(const FormTypeChanged(AccountPermission.guest));
  }
}
