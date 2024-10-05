import 'package:flutter/cupertino.dart';
import 'package:os_core/src/storage/settings_storage.dart';
import 'package:provider/provider.dart';

class OsVolumeController extends ChangeNotifier {

  static OsVolumeController read(BuildContext context) {
    return context.read<OsVolumeController>();
  }

  static OsVolumeController watch(BuildContext context) {
    return context.watch<OsVolumeController>();
  }

  int _volume = 100;
  bool _isMuted = false;

  int get volume => _volume;

  bool get isMuted => _isMuted;

  final _settingsStorage = SettingsStorage.instance;

  OsVolumeController() {
    _volume = _settingsStorage.getVolume();
    _isMuted = _settingsStorage.isVolumeMute();
  }

  void setVolume(int volume) {
    _volume = volume;
    _settingsStorage.setVolume(_volume);
    notifyListeners();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    _settingsStorage.setVolumeMute(_isMuted);
    notifyListeners();
  }

  void setMute(bool isMuted) {
    _isMuted = isMuted;
    _settingsStorage.setVolumeMute(_isMuted);
    notifyListeners();
  }
}