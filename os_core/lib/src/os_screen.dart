import 'package:flutter/material.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import 'controllers/cursor_controller.dart';
import 'window_area.dart';

enum OsTaskbarAlignment {
  bottom,
  top,
  left,
  right;

  Alignment get alignment {
    switch (this) {
      case OsTaskbarAlignment.bottom:
        return Alignment.bottomCenter;
      case OsTaskbarAlignment.top:
        return Alignment.topCenter;
      case OsTaskbarAlignment.left:
        return Alignment.centerLeft;
      case OsTaskbarAlignment.right:
        return Alignment.centerRight;
    }
  }
}

class OsScreen extends StatefulWidget {
  final Widget Function(BuildContext context, bool isStartMenuOpened)
      startMenuBuilder;
  final PreferredSizeWidget taskBar;
  final OsTaskbarAlignment taskBarAlignment;
  final bool startMenuOverTaskbar;
  final List<App> fixedTaskbarApps;

  const OsScreen({
    super.key,
    required this.startMenuBuilder,
    required this.taskBar,
    this.startMenuOverTaskbar = false,
    this.taskBarAlignment = OsTaskbarAlignment.bottom,
    this.fixedTaskbarApps = const [],
  });

  @override
  State<OsScreen> createState() => _OsScreenState();
}

class _OsScreenState extends State<OsScreen> {
  @override
  void initState() {
    context.read<RunningAppsController>().setFixedApps(widget.fixedTaskbarApps);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   App.tryOpen(context, SettingsApp());
      context.read<OsThemeController>().startApp();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tbAlign = widget.taskBarAlignment;
    final taskbarHeight = widget.taskBar.preferredSize.height;
    final taskbarWidth = widget.taskBar.preferredSize.width;
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
          if (!widget.startMenuOverTaskbar)
            Positioned.fill(
                top: tbAlign == OsTaskbarAlignment.top ? taskbarHeight - 1 : 0,
                bottom: tbAlign == OsTaskbarAlignment.bottom
                    ? taskbarHeight - 1
                    : 0,
                left: tbAlign == OsTaskbarAlignment.left ? taskbarWidth - 1 : 0,
                right:
                    tbAlign == OsTaskbarAlignment.right ? taskbarWidth - 1 : 0,
                child: Stack(
                  children: [
                    widget.startMenuBuilder(context, rap.isStartMenuOpened),
                  ],
                )),

          /// taskbar
          Align(
            alignment: widget.taskBarAlignment.alignment,
            child: SizedBox(
                height: widget.taskBar.preferredSize.height,
                width: widget.taskBar.preferredSize.width,
                child: widget.taskBar),
          ),
          if (widget.startMenuOverTaskbar)
            Positioned.fill(
                child: Stack(
              children: [
                widget.startMenuBuilder(context, rap.isStartMenuOpened),
              ],
            )),

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
