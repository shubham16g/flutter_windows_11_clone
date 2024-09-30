import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/app_background.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import '../../os/app/widgets/appbar_corner_buttons.dart';

class SettingsPage extends StatelessWidget {
  final Rect rect;

  const SettingsPage({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    final themeController = context.watch<OsThemeController>();
    return AppBackground(
      blurBackground: true,
      isFocused: appController.isFocused,
      isFullScreen: appController.isFullScreen,
      rect: rect,
      child: Column(
        children: [
          const AppTitleBar(trailing: AppbarCornerButtons()),
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
