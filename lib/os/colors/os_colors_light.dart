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

}