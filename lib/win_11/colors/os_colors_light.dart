import 'dart:ui';

import 'os_colors.dart';

class OsColorLight with OsColor {
  @override
  Color get appBackground => const Color(0xFFf3f3f3);

  @override
  Color get appBorder => const Color(0x5F393939);

  @override
  Color get taskbarBorder => const Color(0x28474747);

  @override
  Color get iconColor => const Color(0xFF000000);

  @override
  Color get iconColorUnFocus => const Color(0xB6171717);

  @override
  Color get textPrimary => const Color(0xFF000000);

  @override
  Color get textSecondary => const Color(0x8A000000);

  @override
  Color get textTertiary => const Color(0x61000000);

  @override
  Color get glassOverlay1 => const Color(0xFFFFFFFF).withOpacity(0.3);

  @override
  Color get glassOverlay2 => const Color(0x00FFFFFF);

  @override
  Color get glassDivider => const Color(0x28474747).withOpacity(0.1);

}