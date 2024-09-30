import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class OsThemeController extends ChangeNotifier {

  static OsThemeController read(BuildContext context) {
    return context.read<OsThemeController>();
  }

  static OsThemeController watch(BuildContext context) {
    return context.watch<OsThemeController>();
  }

  ThemeMode themeMode = ThemeMode.light;
  final _box = Hive.box<String>('os');
  bool appStarted = false;

  OsThemeController() {
    themeMode = _box.get('theme', defaultValue: ThemeMode.light.name) == ThemeMode.light.name
        ? ThemeMode.light
        : ThemeMode.dark;
    print('ThemeController: $themeMode, ${_box.get('theme', defaultValue: ThemeMode.light.name)}');
    notifyListeners();
  }
  Future<void> startApp() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    appStarted = true;
    notifyListeners();
  }

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _box.put('theme', themeMode.name);
    notifyListeners();
  }

  void setDark() {
    themeMode = ThemeMode.dark;
    _box.put('theme', themeMode.name);
    notifyListeners();
  }

  void setLight() {
    themeMode = ThemeMode.light;
    _box.put('theme', themeMode.name);
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;
}
