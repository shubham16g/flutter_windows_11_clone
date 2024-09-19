import 'package:flutter/material.dart';

abstract class App {
  String get title;

  Widget get icon;

  double get minWidth => 300;

  double get minHeight => 150;

  double get appBarHeight => 40;
}

class FileExplorerApp extends App {
  @override
  String get title => 'File Explorer';

  @override
  Widget get icon => const Icon(Icons.folder);

}

class SettingsApp extends App {
  @override
  String get title => 'Settings';

  @override
  Widget get icon => const Icon(Icons.settings);
}
