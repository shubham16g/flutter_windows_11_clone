import 'package:fluent_ui/fluent_ui.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import 'start_menu/start_menu.dart';
import 'taskbar/taskbar.dart';

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

  DesktopOverlayController(this.runningAppsController);

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

class DesktopOverlay extends StatelessWidget {
  const DesktopOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DesktopOverlayController(context.read()),
        builder: (context, _) {
          final overlayController = context.watch<DesktopOverlayController>();
          const taskBar = Taskbar();
          final tbAlign = overlayController.taskbarAlignment;
          final taskbarHeight = taskBar.preferredSize.height;
          final taskbarWidth = taskBar.preferredSize.width;
          return Stack(
            children: [
              Positioned.fill(
                  child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (details) {
                  context.read<DesktopOverlayController>().closeStartMenu();
                },
              )),
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
                      StartMenu(
                          isStartMenuOpened:
                              overlayController.isStartMenuOpened),
                    ],
                  )),

              /// taskbar
              Align(
                alignment: tbAlign.alignment,
                child: SizedBox(
                    height: taskBar.preferredSize.height,
                    width: taskBar.preferredSize.width,
                    child: taskBar),
              ),
            ],
          );
        });
  }
}
