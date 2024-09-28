import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/app_background.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/wallpaper_blur_bg.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
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

  double initialWidth = 700;
  double initialHeight = 520;

  Widget builder(BuildContext context, Rect rect);

  static void tryOpen(BuildContext context, App app) {
    final rap = context.read<RunningAppsController>();
    final windowAreaSize =
        Size(context.screenSize.width, context.screenSize.height - 48);
    final windowPaddedWidth = windowAreaSize.width - 20;
    final windowPaddedHeight = windowAreaSize.height - 20;
    if (!rap.isAppOpen(app)) {
      rap.openApp(AppController(
          runningAppsController: rap,
          cursorController: context.read(),
          initialHeight: app.initialHeight > windowPaddedHeight
              ? windowPaddedHeight
              : app.initialHeight,
          initialWidth: app.initialWidth > windowPaddedWidth
              ? windowPaddedWidth
              : app.initialWidth,
          windowAreaSize: windowAreaSize,
          initialIsFullScreen: false,
          app: app));
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
  Widget get icon => SvgPicture.asset(
        'assets/icons/file_explorer_app.svg',
        width: 24,
      );

  @override
  bool get isMultiInstance => true;

  @override
  Widget builder(BuildContext context, Rect rect) {
    return AppBackground(
      child: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: AppbarCornerButtons(
                isDark: context.isDark,
              )),
        ],
      ),
    );
  }
}

class EdgeApp extends App {
  @override
  String get title => 'Edge';

  @override
  Widget get icon => SvgPicture.asset(
        'assets/icons/edge_app.svg',
        width: 30,
      );

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
