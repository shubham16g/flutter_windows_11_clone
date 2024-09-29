import 'dart:ui';

import 'os_colors.dart';

class OsColorDark with OsColor {
  @override
  Color get appBackground => const Color(0xFF202020);

  @override
  Color get appBorder => const Color(0xFF757575).withOpacity(0.6);

  @override
  Color get taskbarBorder => const Color(0xFF757575).withOpacity(0.6);

  @override
  Color get iconColor => const Color(0xFFFFFFFF);

  @override
  Color get iconColorUnFocus => const Color(0x96F4F4F4);

}