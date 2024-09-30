import 'package:flutter/material.dart';
import 'package:os_core/os_core.dart';
import 'package:os_core/src/start_menu.dart';
import 'package:provider/provider.dart';

import 'controllers/cursor_controller.dart';
import 'controllers/os_theme_controller.dart';
import 'window_area.dart';

class OsScreen extends StatefulWidget {
  final Widget Function(BuildContext context, bool isStartMenuOpened)
      startMenuBuilder;
  final PreferredSizeWidget taskBar;

  const OsScreen(
      {super.key, required this.startMenuBuilder, required this.taskBar});

  @override
  State<OsScreen> createState() => _OsScreenState();
}

class _OsScreenState extends State<OsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   App.tryOpen(context, SettingsApp());
      context.read<OsThemeController>().startApp();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperWrapper = context.watch<WallpaperController>();
    final themeController = context.watch<OsThemeController>();
    final rap = context.watch<RunningAppsController>();
    return Material(
      child: Stack(
        children: [
          if (wallpaperWrapper.wallpaperPath != null)
            Positioned.fill(
              child: Image.asset(
                wallpaperWrapper.wallpaperPath!,
                fit: BoxFit.cover,
              ),
            ),

          /// desktop area
          Positioned.fill(
            child: MouseRegion(
              cursor: context.watch<CursorController>().cursor,
              onEnter: (event) {
                context.read<CursorController>().setCursor(MouseCursor.defer);
              },
              onExit: (event) {},
              child: const WindowArea(),
            ),
          ),

          /// start menu
         widget.startMenuBuilder(context, rap.isStartMenuOpened),

          /// taskbar
          Positioned(left: 0, right: 0, bottom: 0, child: widget.taskBar),

          Positioned.fill(
            child: IgnorePointer(
              ignoring: themeController.appStarted,
              child: AnimatedOpacity(
                opacity: themeController.appStarted ? 0 : 1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                child: Container(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
