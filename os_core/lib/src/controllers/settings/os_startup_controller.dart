import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:os_core/src/storage/settings_storage.dart';
import 'package:provider/provider.dart';

class OsStartupController extends ChangeNotifier {
  static OsStartupController read(BuildContext context) {
    return context.read<OsStartupController>();
  }

  static OsStartupController watch(BuildContext context) {
    return context.watch<OsStartupController>();
  }

  bool _isOsStarted = false;

  bool get isOsStarted => _isOsStarted;

  Future<void> startOs() async {
    await Future.delayed(const Duration(milliseconds: kDebugMode ? 700 : 1500));
    _isOsStarted = true;
    notifyListeners();
  }
}
