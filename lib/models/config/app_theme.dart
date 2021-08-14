import 'dart:ui';

class AppThemeModel {
  final Color primaryColor;
  final Color secondaryColor;
  final Color bottomNotePrimaryColor;
  final Color bottomNoteSecondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color tableCellColor;
  final String name;

  const AppThemeModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.bottomNotePrimaryColor,
    required this.bottomNoteSecondaryColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.tableCellColor,
    required this.name,
  });
}
