import 'package:flutter/cupertino.dart';
import 'package:os_core/src/storage/settings_storage.dart';
import 'package:provider/provider.dart';

class OsWifiController extends ChangeNotifier {

  static OsWifiController read(BuildContext context) {
    return context.read<OsWifiController>();
  }

  static OsWifiController watch(BuildContext context) {
    return context.watch<OsWifiController>();
  }

  bool _isWifiOn = false;

  bool get isWifiOn => _isWifiOn;

  final _settingsStorage = SettingsStorage.instance;

  OsWifiController() {
    _isWifiOn = _settingsStorage.isWifiOn();
  }

  void toggleWifi() {
    _isWifiOn = !_isWifiOn;
    _settingsStorage.setWifi(_isWifiOn);
    notifyListeners();
  }
}