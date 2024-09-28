import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/wallpaper_blur_bg.dart';
import 'package:provider/provider.dart';

import '../controllers/app_controller.dart';
import '../controllers/running_apps_controller.dart';
import 'widgets/appbar_corner_buttons.dart';

abstract class App {
  String get title;

  Widget get icon;

  double get minWidth => 300;

  double get minHeight => 150;

  double get appBarHeight => 40;

  bool get isMultiInstance => false;

  Widget builder(BuildContext context, Rect rect);

  static void tryOpen(BuildContext context, App app) {
    final rap = context.read<RunningAppsController>();
    if (!rap.isAppOpen(app)) {
      rap.openApp(
          AppController(
              runningAppsController: rap,
              cursorController: context.read(), app: app));
    } else if (!rap.isFocusedByApp(app)) {
      rap.focusByApp(app);
    } else {
      rap.toggleMinimizeMaximizeByApp(app);
    }

  }
}

class FileExplorerApp extends App {
  @override
  String get title => 'File Explorer';

  @override
  Widget get icon => const Icon(Icons.folder);

  @override
  bool get isMultiInstance => true;

  @override
  Widget builder(BuildContext context, Rect rect) {
    return Stack(
      children: [
        WallpaperBlurBg(rect: rect),
        const Positioned(
            top: 0,
            right: 0,
            child: AppbarCornerButtons()),
      ],
    );
  }

}

class EdgeApp extends App {
  @override
  String get title => 'Edge';

  @override
  Widget get icon => const Icon(Icons.web);

  @override
  Widget builder(BuildContext context, Rect rect) {
    return Container(
      color: Colors.red,
    );
  }
}

class CopilotApp extends App {
  @override
  String get title => 'Copilot';

  @override
  Widget get icon => const Icon(Icons.assistant);

  @override
  Widget builder(BuildContext context, Rect rect) {
    return Container(
      color: Colors.red,
    );
  }
}
