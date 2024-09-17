import 'package:flutter/cupertino.dart';
import 'package:flutter_windows_11_clone/providers/app_controller.dart';

import 'apps.dart';

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
  final List<Widget> _runningAppsWidgets = [];
  final List<AppController> _runningAppsControllers = [];

  final List<TaskbarAppState> taskbarApps = [
    TaskbarAppState(app: App.fileExplorer, fixed: true),
  ];


  List<Widget> get runningAppsWidgets => _runningAppsWidgets;

  App get focusedApp => _runningAppsControllers.isNotEmpty ? _runningAppsControllers.first.app : App.fileExplorer;


  void openApp(Widget appWidget, AppController appController) {
    _runningAppsWidgets.add(appWidget);
    _runningAppsControllers.add(appController);
    final index = taskbarApps.indexWhere((element) => element.app == appController.app);
    if (index == -1) {
      taskbarApps.add(TaskbarAppState(app: appController.app, openCount: 1));
    } else {
      taskbarApps[index] = taskbarApps[index].copyWith(openCount: taskbarApps[index].openCount + 1);
    }
    notifyListeners();
  }

  void closeApp(AppController appController) {
    final index = _runningAppsControllers.indexOf(appController);
    _runningAppsWidgets.removeAt(index);
    _runningAppsControllers.removeAt(index);
    final taskbarIndex = taskbarApps.indexWhere((element) => element.app == appController.app);
    if (taskbarIndex != -1) {
      taskbarApps[taskbarIndex] = taskbarApps[taskbarIndex].copyWith(openCount: taskbarApps[taskbarIndex].openCount - 1);
    }
    notifyListeners();
  }

  void focusApp(AppController appController) {
    final index = _runningAppsControllers.indexOf(appController);
    final appWidget = _runningAppsWidgets.removeAt(index);
    _runningAppsWidgets.insert(0, appWidget);
    final controller = _runningAppsControllers.removeAt(index);
    _runningAppsControllers.insert(0, controller);
    notifyListeners();
  }
}