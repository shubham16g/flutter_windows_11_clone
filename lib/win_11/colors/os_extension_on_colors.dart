import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

import 'os_colors.dart';
import 'os_colors_dark.dart';
import 'os_colors_light.dart';

final osColorLight = OsColorLight();
final osColorDark = OsColorDark();

extension OxExtensionOnColor on BuildContext {
  OsColor get osColor => getOsColor(isDark: Theme.of(this).brightness == Brightness.dark);

  FluentThemeData get theme => FluentTheme.of(this);

  OsColor getOsColor({required bool isDark}) => isDark ? osColorDark : osColorLight;
}
