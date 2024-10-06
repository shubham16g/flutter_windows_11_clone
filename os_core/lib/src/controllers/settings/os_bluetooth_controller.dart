import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../storage/settings_storage.dart';

class OsBluetoothController extends ChangeNotifier {
  static OsBluetoothController read(BuildContext context) {
    return context.read<OsBluetoothController>();
  }

  static OsBluetoothController watch(BuildContext context) {
    return context.watch<OsBluetoothController>();
  }

  bool _isBluetoothOn = false;

  bool get isBluetoothOn => _isBluetoothOn;

  final _settingsStorage = SettingsStorage.instance;

  OsBluetoothController() {
    _isBluetoothOn = _settingsStorage.isBluetoothOn();
  }

  void toggleWifi() {
    _isBluetoothOn = !_isBluetoothOn;
    _settingsStorage.setBluetooth(_isBluetoothOn);
    notifyListeners();
  }
}