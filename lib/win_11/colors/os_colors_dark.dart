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

  @override
  Color get textPrimary => const Color(0xFFFFFFFF);

  @override
  Color get textSecondary => const Color(0x8AFFFFFF);

  @override
  Color get textTertiary => const Color(0x61FFFFFF);

  @override
  Color get glassOverlay1 => const Color(0x00000000);

  @override
  Color get glassOverlay2 => const Color(0xFF000000).withOpacity(0.2);

  @override
  Color get glassDivider => const Color(0xFF757575).withOpacity(0.1);

}