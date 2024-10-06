import 'package:flutter/material.dart';
import 'package:os_core/os_core.dart';
import 'package:os_core/src/controllers/settings/os_startup_controller.dart';
import 'package:os_core/src/widget/brightness_overlay.dart';
import 'package:provider/provider.dart';

import 'controllers/cursor_controller.dart';
import 'widget/night_light_overlay.dart';
import 'window_area.dart';

class OsScreen extends StatefulWidget {
  final Widget desktop;
  final Widget desktopOverlay;
  final List<App> fixedTaskbarApps;

  const OsScreen({
    super.key,
    required this.desktop,
    required this.desktopOverlay,
    this.fixedTaskbarApps = const [],
  });

  @override
  State<OsScreen> createState() => _OsScreenState();
}

class _OsScreenState extends State<OsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   App.tryOpen(context, SettingsApp());
      context.read<RunningAppsController>().setFixedApps(widget.fixedTaskbarApps);
      OsStartupController.read(context).startOs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperWrapper = context.watch<WallpaperController>();
    final themeController = context.watch<OsThemeController>();
    final rap = context.watch<RunningAppsController>();
    return Material(
      child: NightLightOverlay(
        child: Stack(
          children: [
            Positioned.fill(
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      return Stack(
                        children: [
                          if (wallpaperWrapper.wallpaperPath != null)
                            Positioned.fill(
                              child: Image.asset(
                                wallpaperWrapper.wallpaperPath!,
                                fit: BoxFit.cover,
                              ),
                            ),

                          /// desktop
                          Positioned.fill(
                            child: widget.desktop,
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

                          /// desktop overlay
                          Positioned.fill(
                            child: widget.desktopOverlay,
                          ),
                        ],
                      );
                    }
                  ),
                ],
              ),
            ),
            const Positioned.fill(
              child: OsStartupOverlay(),
            ),
            const Positioned.fill(
              child: BrightnessOverlay(),
            ),
            // const Positioned.fill(
            //   child: NightLightOverlay(),
            // ),
          ],
        ),
      ),
    );
  }
}

class OsStartupOverlay extends StatelessWidget {
  const OsStartupOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final osStartupController = OsStartupController.watch(context);
    return IgnorePointer(
      ignoring: osStartupController.isOsStarted,
      child: AnimatedOpacity(
        opacity: osStartupController.isOsStarted ? 0 : 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        child: Container(color: Colors.black),
      ),
    );
  }
}

