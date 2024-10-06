import 'package:flutter/cupertino.dart';
import 'package:os_core/src/storage/settings_storage.dart';
import 'package:provider/provider.dart';

class OsBatteryController extends ChangeNotifier {

  static OsBatteryController read(BuildContext context) {
    return context.read<OsBatteryController>();
  }

  static OsBatteryController watch(BuildContext context) {
    return context.watch<OsBatteryController>();
  }

  bool _isBatterySaverOn = false;

  // todo: implement battery level
  int batteryLevel = 69;

  bool get isBatterySaverOn => _isBatterySaverOn;

  final _settingsStorage = SettingsStorage.instance;

  OsBatteryController() {
    _isBatterySaverOn = _settingsStorage.isBatterySaverOn();
  }

  void toggleBatterySaver() {
    _isBatterySaverOn = !_isBatterySaverOn;
    _settingsStorage.setBatterySaver(_isBatterySaverOn);
    notifyListeners();
  }
}