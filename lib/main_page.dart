import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/main.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/widgets/taskbar.dart';
import 'package:flutter_windows_11_clone/widgets/window_area.dart';
import 'package:provider/provider.dart';

import 'providers/cursor_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/wall_${context.isDark ? 'dark' : 'light'}.jpg',
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
  }
}
