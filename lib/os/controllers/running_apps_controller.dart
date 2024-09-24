import 'package:flutter/cupertino.dart';

import '../app/controller/app_controller.dart';
import '../app/apps.dart';

class TaskbarAppState {
  final App app;
  final int openCount;
  final bool fixed;

  TaskbarAppState({
    required this.app,
    this.openCount = 0,
    this.fixed = false,
  });

  TaskbarAppState copyWith({
    App? app,
    int? openCount,
    bool? fixed,
  }) {
    return TaskbarAppState(
      app: app ?? this.app,
      openCount: openCount ?? this.openCount,
      fixed: fixed ?? this.fixed,
    );
  }
}

class RunningAppsProvider extends ChangeNotifier { 
  final List<AppController> _runningAppsControllers = [];

  final List<TaskbarAppState> taskbarApps = [
    TaskbarAppState(app: FileExplorerApp(), fixed: true),
    TaskbarAppState(app: SettingsApp(), fixed: true),
  ];

  List<AppController> get runningAppsControllers => _runningAppsControllers;

  void openApp(Widget appWidget, AppController appController) {
    final index = taskbarApps.indexWhere(
        (element) => element.app.runtimeType == appController.app.runtimeType);
    if (index == -1) {
      /// not found in taskbar, open new app
      _runningAppsControllers.add(appController);
      taskbarApps.add(TaskbarAppState(app: appController.app, openCount: 1));
    } else if (appController.app.isMultiInstance ||
        taskbarApps[index].openCount == 0) {
      /// found in taskbar, open new instance (isMultiInstance = true)
      /// or fixed on taskbar but not opened yet
      _runningAppsControllers.add(appController);
      taskbarApps[index] = taskbarApps[index]
          .copyWith(openCount: taskbarApps[index].openCount + 1);
    }
    notifyListeners();
  }

  App? get focusedApp {
    if (_runningAppsControllers.isEmpty) return null;
    final index = _runningAppsControllers
        .lastIndexWhere((element) => !element.isMinimized);
    if (index == -1) return null;
    final controller = _runningAppsControllers[index];
    return controller.app;
  }

  bool isFocused(App app) {
    return focusedApp?.runtimeType == app.runtimeType;
  }

  Future<void> closeApp(AppController appController) async {
    await appController.closeAppAnim();
    final index = _runningAppsControllers.indexOf(appController);
    _runningAppsControllers.removeAt(index);
    final taskbarIndex =
        taskbarApps.indexWhere((element) => element.app == appController.app);
    if (taskbarIndex != -1) {
      taskbarApps[taskbarIndex] = taskbarApps[taskbarIndex]
          .copyWith(openCount: taskbarApps[taskbarIndex].openCount - 1);
    }
    notifyListeners();
  }

  void focusByApp(App app) {
    final index =
        _runningAppsControllers.indexWhere((element) => element.app == app);
    if (index != -1) {
      final controller = _runningAppsControllers.removeAt(index);
      _runningAppsControllers.add(controller);
      controller.maximize();
      notifyListeners();
    }
  }

  void toggleMinimizeMaximizeByApp(App app) {
    final index =
        _runningAppsControllers.indexWhere((element) => element.app == app);
    if (index != -1) {
      final controller = _runningAppsControllers[index];
      toggleMinimizeMaximize(controller);
    }
  }

  void toggleMinimizeMaximize(AppController appController) {
    appController.toggleMinimizeMaximize();
    if (appController.isMinimized) {
      final index = _runningAppsControllers.indexOf(appController);
      if (index != _runningAppsControllers.length - 1) {
        notifyListeners();
        return;
      };
      final focusAppIndex = _runningAppsControllers
          .lastIndexWhere((element) => !element.isMinimized);
      if (focusAppIndex == -1) {
        notifyListeners();
        return;
      }

      /// if it is not in focus
      final controller = _runningAppsControllers.removeAt(index);
      _runningAppsControllers.insert(focusAppIndex, controller);
    } else {
      final index = _runningAppsControllers.indexOf(appController);
      final controller = _runningAppsControllers.removeAt(index);
      _runningAppsControllers.add(controller);
    }
    notifyListeners();
  }

  void focusApp(AppController appController) {
    final index = _runningAppsControllers.indexOf(appController);
    final controller = _runningAppsControllers.removeAt(index);
    _runningAppsControllers.add(controller);
    notifyListeners();
  }
}
