library os_win_11;

import 'package:os_core/os_core.dart' show OsCore;

export './src/win_11_builder.dart';
export './src/common_widgets/app_background.dart';
export './src/common_widgets/appbar_corner_buttons.dart';
export './src/common_widgets/glass_blur_bg.dart';
export './src/common_widgets/glass_button.dart';
export './src/common_widgets/custom_overlay_animated.dart';
export './src/common_widgets/custom_overlay.dart';
export './src/colors/os_extension_on_colors.dart';
export './src/utils/ui_utils.dart';

export 'package:os_core/os_core.dart' show AppTitleBar, App, AppController;
export 'package:fluentui_system_icons/fluentui_system_icons.dart';
export 'package:fluent_ui/fluent_ui.dart' hide FluentIcons, Colors;

class OsWin11 {
  static Future<void> init() async {
    await OsCore.init();
  }
}

