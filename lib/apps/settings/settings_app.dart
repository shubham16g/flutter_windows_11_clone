import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:os_win_11/os_win_11.dart';
import 'package:provider/provider.dart';
import 'package:settings_app_win_11/settings_app.dart' as settings;


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
    return AppBackground(
      wallpaperBlur: true,
      isFocused: appController.isFocused,
      isFullScreen: appController.isFullScreen,
      rect: rect,
      child: Stack(
        children: [
          const Positioned.fill(
            child: ClipRect(
              child: settings.SettingsApp(),
            ),
          ),
          Positioned(
            top: 0,
              right: 0,
              child: AppbarCornerButtons(isDark: context.isDark)),
        ],
      ),
    );
  }
}
