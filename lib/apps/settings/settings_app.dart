import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/apps/settings/settings_page.dart';

import '../../os/app/apps.dart';

class SettingsApp extends App {
  @override
  String get title => 'Settings';

  @override
  Widget get icon => const Icon(Icons.settings);

  @override
  Widget builder(BuildContext context) =>  const SettingsPage();
}