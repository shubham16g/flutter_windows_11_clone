import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/desktop_overlay_controller.dart';
import 'start_menu_closer.dart';

class DesktopOverlay extends StatelessWidget {
  final Widget Function(BuildContext context, bool isOpened) startMenuBuilder;
  final PreferredSizeWidget Function(
      BuildContext context, TaskbarAlignment alignment) taskbarBuilder;

  const DesktopOverlay(
      {super.key,
      required this.startMenuBuilder,
      required this.taskbarBuilder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DesktopOverlayController(context.read()),
        builder: (context, _) {
          final overlayController = context.watch<DesktopOverlayController>();
          final tbAlign = overlayController.taskbarAlignment;
          final taskbar = taskbarBuilder(context, tbAlign);
          final taskbarHeight = taskbar.preferredSize.height;
          final taskbarWidth = taskbar.preferredSize.width;
          return Stack(
            children: [
              const Positioned.fill(child: StartMenuCloser()),
              Positioned.fill(
                  top: tbAlign == TaskbarAlignment.top ? taskbarHeight - 1 : 0,
                  bottom: tbAlign == TaskbarAlignment.bottom
                      ? taskbarHeight - 1
                      : 0,
                  left: tbAlign == TaskbarAlignment.left ? taskbarWidth - 1 : 0,
                  right:
                      tbAlign == TaskbarAlignment.right ? taskbarWidth - 1 : 0,
                  child: Stack(
                    children: [
                      startMenuBuilder(
                          context, overlayController.isStartMenuOpened),
                    ],
                  )),

              /// taskbar
              Align(
                alignment: tbAlign.alignment,
                child: SizedBox(
                    height: taskbar.preferredSize.height,
                    width: taskbar.preferredSize.width,
                    child: taskbar),
              ),
            ],
          );
        });
  }
}