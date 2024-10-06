import 'package:flutter/cupertino.dart';
import 'package:os_core/src/storage/settings_storage.dart';
import 'package:provider/provider.dart';

class OsBrightnessController extends ChangeNotifier {

  static OsBrightnessController read(BuildContext context) {
    return context.read<OsBrightnessController>();
  }

  static OsBrightnessController watch(BuildContext context) {
    return context.watch<OsBrightnessController>();
  }

  int _brightness = 100;

  int get brightness => _brightness;

  final _settingsStorage = SettingsStorage.instance;

  OsBrightnessController() {
    _brightness = _settingsStorage.getBrightness();
  }

  void setBrightness(int brightness) {
    _brightness = brightness;
    _settingsStorage.setBrightness(_brightness);
    notifyListeners();
  }
}