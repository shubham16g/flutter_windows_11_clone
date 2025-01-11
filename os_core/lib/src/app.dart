import 'package:flutter/material.dart';
import 'package:os_core/src/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import 'controllers/app_controller.dart';
import 'controllers/running_apps_controller.dart';


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
    final rap = context.read<OsAppsController>();
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