import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  final box = Hive.box<String>('os');

  ThemeController() {
    themeMode = box.get('theme', defaultValue: ThemeMode.light.name) == ThemeMode.light.name
        ? ThemeMode.light
        : ThemeMode.dark;
    print('ThemeController: $themeMode, ${box.get('theme', defaultValue: ThemeMode.light.name)}');
    notifyListeners();
  }

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    box.put('theme', themeMode.name);
    notifyListeners();
  }

  void setDark() {
    themeMode = ThemeMode.dark;
    box.put('theme', themeMode.name);
    notifyListeners();
  }

  void setLight() {
    themeMode = ThemeMode.light;
    box.put('theme', themeMode.name);
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;
}
