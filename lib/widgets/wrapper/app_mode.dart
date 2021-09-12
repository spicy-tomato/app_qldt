import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/enums/config/app_mode.dart';
import 'package:flutter/widgets.dart';

class AppModeWidget extends InheritedWidget {
  final AppMode mode;
  final ApiUrl apiUrl;

  AppModeWidget({
    Key? key,
    required this.mode,
    required Widget child,
  })  : apiUrl = ApiUrl(mode),
        super(key: key, child: child);

  static AppModeWidget of(BuildContext context) {
    final AppModeWidget? result = context.dependOnInheritedWidgetOfExactType<AppModeWidget>();
    assert(result != null, 'No UrlProvider found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(oldWidget) => false;
}
