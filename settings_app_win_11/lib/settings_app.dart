library settings_app_win_11;

import 'package:flutter/material.dart';
import 'package:settings_app_win_11/src/router.dart';

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: Theme.of(context),
    );
  }
}
