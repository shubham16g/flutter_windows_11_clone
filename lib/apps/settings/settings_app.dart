import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/apps/settings/settings_page.dart';

import '../../os/app/apps.dart';

class SettingsApp extends App {
  @override
  String get title => 'Settings';

  @override
  Widget get icon => SvgPicture.asset(
    'assets/icons/settings_app.svg',
    width: 30,
  );

  @override
  Widget builder(BuildContext context, Rect rect) =>  SettingsPage(rect: rect);
}