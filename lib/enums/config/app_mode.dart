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
