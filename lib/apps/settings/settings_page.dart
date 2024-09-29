import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/app/widgets/win_app_bar.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/app_background.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../os/app/widgets/appbar_corner_buttons.dart';
import '../../os/controllers/app_controller.dart';
import '../../os/controllers/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  final Rect rect;

  const SettingsPage({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    final themeController = context.watch<ThemeController>();
    return AppBackground(
      blurBackground: true,
      isFocused: appController.isFocused,
      isFullScreen: appController.isFullScreen,
      rect: rect,
      child: Column(
        children: [
          const WinAppBar(),
          Expanded(
              child: Center(
            child: Switch(
                value: themeController.isDark,
                onChanged: (value) {
                  value
                      ? themeController.setDark()
                      : themeController.setLight();
                }),
          ))
        ],
      ),
    );
  }
}
