import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/apps/settings/settings_page.dart';
import 'package:os_core/os_core.dart';

class SettingsApp extends App {
  @override
  String get title => 'Settings';

  @override
  Widget get icon => SvgPicture.asset(
    'assets/icons/settings_app.svg',
    width: 30,
  );

  @override
  double get initialHeight => 800;

  @override
  double get initialWidth => 1000;

  @override
  Widget builder(BuildContext context, Rect rect) =>  SettingsPage(rect: rect);
}