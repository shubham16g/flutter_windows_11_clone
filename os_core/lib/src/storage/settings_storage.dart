import 'package:flutter/material.dart';
import 'package:os_core/src/storage/os_core_storage.dart';

SettingsStorage? _settingsStorage;

class SettingsStorage {
  final _box = osBox;

  static SettingsStorage get instance {
    _settingsStorage ??= SettingsStorage();
    return _settingsStorage!;
  }

  static const String _keyTheme = 'theme';
  static const String _keyWifi = 'wifi';
  static const String _keyBluetooth = 'bluetooth';
  static const String _keyBatterySaver = 'battery_saver';

  ThemeMode getTheme() {
    final theme = _box.get(_keyTheme, defaultValue: ThemeMode.light.name);
    return theme == ThemeMode.light.name ? ThemeMode.light : ThemeMode.dark;
  }

  void setTheme(ThemeMode theme) {
    _box.put(_keyTheme, theme.name);
  }

  bool isWifiOn() {
    return _box.get(_keyWifi, defaultValue: 'true') == 'true';
  }

  void setWifi(bool isOn) {
    _box.put(_keyWifi, isOn.toString());
  }

  bool isBluetoothOn() {
    return _box.get(_keyBluetooth, defaultValue: 'true') == 'true';
  }

  void setBluetooth(bool isOn) {
    _box.put(_keyBluetooth, isOn.toString());
  }

  bool isBatterySaverOn() {
    return _box.get(_keyBatterySaver, defaultValue: 'true') == 'true';
  }

  void setBatterySaver(bool isOn) {
    _box.put(_keyBatterySaver, isOn.toString());
  }

}