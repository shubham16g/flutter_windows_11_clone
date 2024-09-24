import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/widgets/taskbar.dart';
import 'package:flutter_windows_11_clone/widgets/wallpaper_wrapper.dart';
import 'package:flutter_windows_11_clone/widgets/window_area.dart';
import 'package:provider/provider.dart';

import 'providers/cursor_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WallpaperWrapper(),
        builder: (context, w) {
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
                    child: const WindowArea(),
                  ),
                ),

                /// taskbar
                const Positioned(left: 0, right: 0, bottom: 0, child: Taskbar())
              ],
            ),
          );
        });
  }
}
