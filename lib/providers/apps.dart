import 'package:flutter/material.dart';

abstract class App {
  String get title;

  Widget get icon;

  double get minWidth => 300;

  double get minHeight => 150;

  double get appBarHeight => 40;

  bool get isMultiInstance => false;
}

class FileExplorerApp extends App {
  @override
  String get title => 'File Explorer';

  @override
  Widget get icon => const Icon(Icons.folder);

  @override
  bool get isMultiInstance => true;

}

class SettingsApp extends App {
  @override
  String get title => 'Settings';

  @override
  Widget get icon => const Icon(Icons.settings);
}

class EdgeApp extends App {
  @override
  String get title => 'Edge';

  @override
  Widget get icon => const Icon(Icons.web);
}

class CopilotApp extends App {
  @override
  String get title => 'Copilot';

  @override
  Widget get icon => const Icon(Icons.assistant);
}
