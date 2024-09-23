import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/providers/running_apps_provider.dart';
import 'package:provider/provider.dart';

import '../os/draggable_window/app_controller.dart';

class AppbarCornerButtons extends StatelessWidget {
  const AppbarCornerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    final rap = context.watch<RunningAppsProvider>();
    return Row(
      children: [
        if (rap.isFocused(appController.app))
          Icon(Icons.circle, size: 10, color: Colors.green),
        _button(const Icon(Icons.minimize), () {
          context
              .read<RunningAppsProvider>()
              .toggleMinimizeMaximize(appController);
        }),
        _button(
            appController.isFullScreen
                ? Transform.rotate(
                    angle: 3.14,
                    child: const Icon(
                      Icons.filter_none,
                      size: 13,
                      color: Colors.white,
                    ))
                : const Icon(Icons.crop_square), () {
          appController.toggleFullScreen();
        }),
        _button(const Icon(Icons.close), () {
          context.read<RunningAppsProvider>().closeApp(appController);
        }, splashColor: Colors.red),
      ],
    );
  }

  Widget _button(Widget icon, VoidCallback onTap, {Color? splashColor}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        overlayColor:
            splashColor != null ? WidgetStatePropertyAll(splashColor) : null,
        child: Container(
          width: 40,
          height: 30,
          alignment: Alignment.center,
          child: IconTheme(
              data: const IconThemeData(size: 16, color: Colors.white),
              child: icon),
        ),
      ),
    );
  }
}
