import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:flutter/widgets.dart';

enum AppMode {
  release,
  staging,
  debug,
}

extension AppModeExtension on AppMode {
  bool get isRelease => this == AppMode.release;

  bool get isStaging => this == AppMode.staging;

  bool get isDebug => this == AppMode.debug;
}

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
