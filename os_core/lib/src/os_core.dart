import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OsCore {
  static Future<void> init() async {
    debugPrint('OsCore init');
    await Hive.initFlutter();
    await Hive.openBox<String>('os');
  }
}