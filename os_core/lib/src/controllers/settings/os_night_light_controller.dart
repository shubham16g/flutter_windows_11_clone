import 'package:flutter/cupertino.dart';
import 'package:os_core/src/storage/settings_storage.dart';
import 'package:provider/provider.dart';

class OsNightLightController extends ChangeNotifier {

  static OsNightLightController read(BuildContext context) {
    return context.read<OsNightLightController>();
  }

  static OsNightLightController watch(BuildContext context) {
    return context.watch<OsNightLightController>();
  }

  int _strength = 100;
  bool _isNightLightOn = false;

  int get strength => _strength;

  bool get isNightLightOn => _isNightLightOn;

  final _settingsStorage = SettingsStorage.instance;

  OsNightLightController() {
    _strength = _settingsStorage.getNightLightStrength();
    _isNightLightOn = _settingsStorage.isNightLightOn();
  }

  void setNightLightStrength(int strength) {
    _strength = strength;
    _settingsStorage.setNightLightStrength(_strength);
    notifyListeners();
  }

  void toggleNightLight() {
    _isNightLightOn = !_isNightLightOn;
    _settingsStorage.setNightLight(_isNightLightOn);
    notifyListeners();
  }

  void setNightLight(bool isNightLightOn) {
    _isNightLightOn = isNightLightOn;
    _settingsStorage.setNightLight(_isNightLightOn);
    notifyListeners();
  }
}