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

  final _settingsStorage = SettingsStorage.instance;

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  OsThemeController() {
    _themeMode = _settingsStorage.getTheme();
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _settingsStorage.setTheme(_themeMode);
    notifyListeners();
  }

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    _settingsStorage.setTheme(_themeMode);
    notifyListeners();
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;

}
