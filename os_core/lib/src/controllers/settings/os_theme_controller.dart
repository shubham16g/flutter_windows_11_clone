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
  bool _isNightLight = false;

  ThemeMode get themeMode => _themeMode;

  bool get isNightLight => _isNightLight;

  OsThemeController() {
    _themeMode = _settingsStorage.getTheme();
    _isNightLight = _settingsStorage.isNightLightOn();
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _settingsStorage.setTheme(_themeMode);
    notifyListeners();
  }

  void setDark() {
    _themeMode = ThemeMode.dark;
    _settingsStorage.setTheme(_themeMode);
    notifyListeners();
  }

  void setLight() {
    _themeMode = ThemeMode.light;
    _settingsStorage.setTheme(_themeMode);
    notifyListeners();
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // night light

  void toggleNightLight() {
    _isNightLight = !_isNightLight;
    _settingsStorage.setNightLight(_isNightLight);
    notifyListeners();
  }

  void setNightLight(bool isOn) {
    _isNightLight = isOn;
    _settingsStorage.setNightLight(_isNightLight);
    notifyListeners();
  }

  void turnOnNightLight() {
    _isNightLight = true;
    _settingsStorage.setNightLight(_isNightLight);
    notifyListeners();
  }
}
