import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/apps/settings/settings_page.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';
import 'package:settings_app_win_11/settings_app.dart' as settings;

import '../../win_11/common_widgets/app_background.dart';
import '../../win_11/common_widgets/appbar_corner_buttons.dart';

class SettingsApp extends App {
  @override
  String get title => 'Settings';

  @override
  Widget get icon => SvgPicture.asset(
        'assets/icons/settings_app.svg',
        width: 30,
      );

  @override
  double get initialHeight => 800;

  @override
  double get initialWidth => 1000;

  @override
  Widget builder(BuildContext context, Rect rect) => SettingsPage(rect: rect);
}

class SettingsPage extends StatelessWidget {
  final Rect rect;

  const SettingsPage({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    final themeController = context.watch<OsThemeController>();
    return AppBackground(
      wallpaperBlur: true,
      isFocused: appController.isFocused,
      isFullScreen: appController.isFullScreen,
      rect: rect,
      child: Column(
        children: [
          AppTitleBar(trailing: AppbarCornerButtons(isDark: context.isDark)),
          const Expanded(
            child: ClipRect(
              child: settings.SettingsApp(),
            ),
          )
        ],
      ),
    );
  }
}
