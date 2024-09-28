import 'dart:ui';

import 'os_colors.dart';

class OsColorDark with OsColor {
  @override
  Color get appBackground => const Color(0xFF202020);

  @override
  Color get appBorder => const Color(0xFF757575).withOpacity(0.6);

}