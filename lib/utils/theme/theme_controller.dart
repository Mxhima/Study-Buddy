import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDark';

  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  bool _loadTheme() => _box.read(_key) ?? false;

  void saveTheme(bool isDark) => _box.write(_key, isDark);
  void changeTheme(ThemeData theme) => Get.changeTheme(theme);
  void changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);
}
