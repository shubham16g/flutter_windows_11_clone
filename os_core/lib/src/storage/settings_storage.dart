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
  static const String _keyNightLight = 'night_light';
  static const String _keyNightLightStrength = 'night_light_strength';
  static const String _keyVolume = 'volume';
  static const String _keyVolumeMute = 'volume_mute';
  static const String _keyBrightness = 'brightness';

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
    return _box.get(_keyBatterySaver, defaultValue: 'false') == 'true';
  }

  void setBatterySaver(bool isOn) {
    _box.put(_keyBatterySaver, isOn.toString());
  }

  bool isNightLightOn() {
    return _box.get(_keyNightLight, defaultValue: 'false') == 'true';
  }

  void setNightLight(bool isOn) {
    _box.put(_keyNightLight, isOn.toString());
  }

  int getNightLightStrength() {
    return int.tryParse(_box.get(_keyNightLightStrength) ?? '') ?? 100;
  }

  void setNightLightStrength(int strength) {
    _box.put(_keyNightLightStrength, strength.toString());
  }

  int getVolume() {
    return int.tryParse(_box.get(_keyVolume) ?? '') ?? 80;
  }

  void setVolume(int volume) {
    _box.put(_keyVolume, volume.toString());
  }

  bool isVolumeMute() {
    return _box.get(_keyVolumeMute, defaultValue: 'false') == 'true';
  }

  void setVolumeMute(bool isMute) {
    _box.put(_keyVolumeMute, isMute.toString());
  }

  int getBrightness() {
    return int.tryParse(_box.get(_keyBrightness) ?? '') ?? 100;
  }

  void setBrightness(int brightness) {
    _box.put(_keyBrightness, brightness.toString());
  }

}