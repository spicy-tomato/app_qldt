import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginInfo(String studentId) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('student_id', studentId);
}

Future<String> getSavedLoginInfo() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('student_id');
}