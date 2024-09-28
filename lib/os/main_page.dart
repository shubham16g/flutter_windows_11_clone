import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/apps/settings/settings_app.dart';
import 'package:flutter_windows_11_clone/os/app/apps.dart';
import 'package:flutter_windows_11_clone/os/widgets/start_menu.dart';
import 'package:flutter_windows_11_clone/os/widgets/taskbar.dart';
import 'package:flutter_windows_11_clone/os/controllers/wallpaper_controller.dart';
import 'package:flutter_windows_11_clone/os/widgets/window_area.dart';
import 'package:provider/provider.dart';

import 'controllers/cursor_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   App.tryOpen(context, SettingsApp());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperWrapper = context.watch<WallpaperWrapper>();
    return Material(
      child: Stack(
        children: [
          if (wallpaperWrapper.wallpaper != null)
            Positioned.fill(
              child: Image(
                image: wallpaperWrapper.wallpaper!.image,
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
              onExit: (event) {
              },
              child: const WindowArea(),
            ),
          ),
          const Positioned.fill(
            bottom: 47,
            child: Stack(
              children: [
                StartMenu(),
              ],
            ),
          ),
          /// taskbar
          const Positioned(left: 0, right: 0, bottom: 0, child: Taskbar())
        ],
      ),
    );
  }
}
