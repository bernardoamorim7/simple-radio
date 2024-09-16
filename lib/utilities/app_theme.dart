import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appThemeProvider = ChangeNotifierProvider<AppTheme>((ref) => AppTheme());

class AppTheme extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  AppTheme() {
    // ignore: discarded_futures
    loadSettings();
  }

  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }

  void toggle() {
    _isDark = !isDark;
    notifyListeners();
  }

  Future<void> loadSettings() async {
    isDark = await getTheme();
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }

  Future<void> setTheme({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', value);
  }

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade200,
      primary: Colors.grey.shade900,
      secondary: Colors.blue.shade200,
      inversePrimary: Colors.grey.shade100,
      error: Colors.red.shade700,
      shadow: Colors.grey.shade800,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade200,
      secondary: Colors.blue.shade200,
      inversePrimary: Colors.grey.shade800,
      error: Colors.red.shade700,
      shadow: Colors.grey.shade200,
    ),
  );
}
