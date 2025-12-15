import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/storage_service.dart';

class ThemeController extends GetxController {
  late final StorageService _storage;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _storage = Get.find<StorageService>();
    _isDarkMode = _storage.getIsDarkMode();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _storage.saveIsDarkMode(_isDarkMode);
    Get.changeThemeMode(themeMode);
    update();
  }
}