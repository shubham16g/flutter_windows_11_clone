import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../os_core.dart';
import 'controllers/cursor_controller.dart';

class OsBuilder extends StatelessWidget {
  final WidgetBuilder builder;

  const OsBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => OsThemeController()),
      ChangeNotifierProvider(create: (context) => CursorController()),
      ChangeNotifierProvider(create: (context) => RunningAppsController()),
      ChangeNotifierProvider(create: (context) => TaskbarController()),
      ChangeNotifierProvider(
          create: (context) => WallpaperController(context.read())),
    ], builder: (context, _) => builder(context));
  }
}
