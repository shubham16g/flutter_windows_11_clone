import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/providers/apps.dart';
import 'package:flutter_windows_11_clone/providers/running_apps_provider.dart';
import 'package:flutter_windows_11_clone/widgets/grain_blur_bg.dart';
import 'package:provider/provider.dart';

import '../os/draggable_window/app_controller.dart';

class Taskbar extends StatelessWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsProvider>();
    final taskbarApps = runningAppsProvider.taskbarApps;
    final focusedApp = runningAppsProvider.focusedApp;
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: const Color(0xFF757575).withOpacity(0.6),
          width: 1,
        ),
      )),
      child: Stack(children: [
        const GrainBlurBg(),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.window),
              ...taskbarApps.map((e) => IconButton(
                  color: e.openCount > 0 ? Colors.white : Colors.grey,
                  onPressed: () {
                    context.read<RunningAppsProvider>().openApp(
                        Container(
                          width: 600,
                          height: 600,
                        ),
                        AppController(
                            cursorController: context.read(),
                            app: e.app));
                  },
                  icon: e.app.icon))
            ],
          ),
        )
      ]),
    );
  }
}
