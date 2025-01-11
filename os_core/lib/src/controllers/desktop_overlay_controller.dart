
import 'package:flutter/material.dart';

import '../../os_core.dart';

enum TaskbarAlignment {
  bottom,
  top,
  left,
  right;

  Alignment get alignment {
    switch (this) {
      case TaskbarAlignment.bottom:
        return Alignment.bottomCenter;
      case TaskbarAlignment.top:
        return Alignment.topCenter;
      case TaskbarAlignment.left:
        return Alignment.centerLeft;
      case TaskbarAlignment.right:
        return Alignment.centerRight;
    }
  }
}

class DesktopOverlayController extends ChangeNotifier {
  final RunningAppsController runningAppsController;

  bool lastIsDesktopFocused = false;

  DesktopOverlayController(this.runningAppsController) {
    runningAppsController.addListener(_listen);
  }

  void _listen() {
    if (lastIsDesktopFocused != runningAppsController.isDesktopFocused &&
        !runningAppsController.isDesktopFocused) {
      isStartMenuOpened = false;
      notifyListeners();
    }
    lastIsDesktopFocused = runningAppsController.isDesktopFocused;
  }

  @override
  void dispose() {
    runningAppsController.removeListener(_listen);
    super.dispose();
  }

  bool isStartMenuOpened = false;

  TaskbarAlignment taskbarAlignment = TaskbarAlignment.bottom;

  void setAlignment(TaskbarAlignment newAlignment) {
    if (taskbarAlignment == newAlignment) return;
    taskbarAlignment = newAlignment;
    notifyListeners();
  }

  bool _startMenuAnim = false;

  void toggleStartMenu() {
    if (_startMenuAnim) return;
    isStartMenuOpened = !isStartMenuOpened;
    if (isStartMenuOpened) {
      runningAppsController.clearAppFocus();
    } else {
      runningAppsController.resetAppFocus();
    }
    notifyListeners();
  }

  void closeStartMenu() {
    if (!isStartMenuOpened) return;
    isStartMenuOpened = false;
    if (_startMenuAnim) return;
    _startMenuAnim = true;
    runningAppsController.resetAppFocus();
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      _startMenuAnim = false;
    });
  }
}
