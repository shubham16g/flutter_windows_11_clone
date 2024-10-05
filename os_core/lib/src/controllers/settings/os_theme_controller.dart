import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../storage/settings_storage.dart';

class OsThemeController extends ChangeNotifier {

  static OsThemeController read(BuildContext context) {
    return context.read<OsThemeController>();
  }

  static OsThemeController watch(BuildContext context) {
    return context.watch<OsThemeController>();
  }

  ThemeMode themeMode = ThemeMode.light;

  final _settingsStorage = SettingsStorage.instance;

  OsThemeController() {
    themeMode = _settingsStorage.getTheme();
    notifyListeners();
  }


  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _settingsStorage.setTheme(themeMode);
    notifyListeners();
  }

  void setDark() {
    themeMode = ThemeMode.dark;
    _settingsStorage.setTheme(themeMode);
    notifyListeners();
  }

  void setLight() {
    themeMode = ThemeMode.light;
    _settingsStorage.setTheme(themeMode);
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;
}
