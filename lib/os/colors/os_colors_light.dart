import 'dart:ui';

import 'os_colors.dart';

class OsColorLight with OsColor {
  @override
  Color get appBackground => const Color(0xFFf3f3f3);

  @override
  Color get appBorder => const Color(0xFF7A7A7A).withOpacity(0.6);

}