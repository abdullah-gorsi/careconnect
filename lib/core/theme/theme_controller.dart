import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  ThemeController(this._preferences)
    : isDarkMode = (_preferences.getBool(_darkModeKey) ?? false).obs;

  static const _darkModeKey = 'dark_mode_enabled';

  final SharedPreferences _preferences;
  final RxBool isDarkMode;

  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  Future<void> setDarkMode(bool enabled) async {
    final saved = await _preferences.setBool(_darkModeKey, enabled);
    if (saved) {
      isDarkMode.value = enabled;
    }
  }
}
