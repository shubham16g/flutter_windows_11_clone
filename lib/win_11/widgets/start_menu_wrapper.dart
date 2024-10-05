import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/slide_anim_wrapper.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import '../common_widgets/app_background.dart';
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

  void toggleStartMenu() {
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
    runningAppsController.resetAppFocus();
    notifyListeners();
  }
}

class DesktopOverlay extends StatelessWidget {
  const DesktopOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    const taskBar = Taskbar();
    final tbAlign = context.watch<DesktopOverlayController>().taskbarAlignment;
    final taskbarHeight = taskBar.preferredSize.height;
    final taskbarWidth = taskBar.preferredSize.width;
    return ChangeNotifierProvider(
        create: (context) => DesktopOverlayController(context.read()),
        builder: (context, _) {
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (details) {
              context.read<DesktopOverlayController>().closeStartMenu();
            },
            child: Stack(
              children: [
                Positioned.fill(
                    top:
                        tbAlign == TaskbarAlignment.top ? taskbarHeight - 1 : 0,
                    bottom: tbAlign == TaskbarAlignment.bottom
                        ? taskbarHeight - 1
                        : 0,
                    left:
                        tbAlign == TaskbarAlignment.left ? taskbarWidth - 1 : 0,
                    right: tbAlign == TaskbarAlignment.right
                        ? taskbarWidth - 1
                        : 0,
                    child: const Stack(
                      children: [
                        StartMenu(),
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
            ),
          );
        });
  }
}
