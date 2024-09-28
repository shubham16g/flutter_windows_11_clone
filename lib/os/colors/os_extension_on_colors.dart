import 'package:flutter/material.dart';

import 'os_colors.dart';
import 'os_colors_dark.dart';
import 'os_colors_light.dart';

final osColorLight = OsColorLight();
final osColorDark = OsColorDark();

extension OxExtensionOnColor on BuildContext {
  OsColor get osColor => Theme.of(this).brightness == Brightness.light
      ? osColorLight
      : osColorDark;
}
