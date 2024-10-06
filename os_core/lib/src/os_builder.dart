import 'package:flutter/material.dart';
import 'package:os_core/src/controllers/settings/os_brightness_controller.dart';
import 'package:os_core/src/controllers/settings/os_night_light_controller.dart';
import 'package:os_core/src/controllers/settings/os_volume_controller.dart';
import 'package:provider/provider.dart';

import 'controllers/cursor_controller.dart';
import 'controllers/running_apps_controller.dart';
import 'controllers/settings/os_battery_controller.dart';
import 'controllers/settings/os_bluetooth_controller.dart';
import 'controllers/settings/os_startup_controller.dart';
import 'controllers/settings/os_theme_controller.dart';
import 'controllers/settings/os_wifi_controller.dart';
import 'controllers/wallpaper_controller.dart';

class OsBuilder extends StatelessWidget {
  final WidgetBuilder builder;

  const OsBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => OsStartupController()),
      ChangeNotifierProvider(create: (context) => OsWifiController()),
      ChangeNotifierProvider(create: (context) => OsBluetoothController()),
      ChangeNotifierProvider(create: (context) => OsNightLightController()),
      ChangeNotifierProvider(create: (context) => OsBrightnessController()),
      ChangeNotifierProvider(create: (context) => OsVolumeController()),
      ChangeNotifierProvider(create: (context) => OsBatteryController()),
      ChangeNotifierProvider(create: (context) => OsThemeController()),
      ChangeNotifierProvider(create: (context) => CursorController()),
      ChangeNotifierProvider(create: (context) => RunningAppsController()),
      ChangeNotifierProvider(
          create: (context) => WallpaperController(context.read())),
    ], builder: (context, _) => builder(context));
  }
}
