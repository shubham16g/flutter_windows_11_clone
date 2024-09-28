import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/glass_blur_bg.dart';
import 'package:flutter_windows_11_clone/os/controllers/running_apps_controller.dart';
import 'package:provider/provider.dart';

import '../app/widgets/draggable_app.dart';

class WindowArea extends StatelessWidget {
  const WindowArea({super.key});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsController>();
    return Stack(
      children: runningAppsProvider.runningAppsControllers
          .map<Widget>((e) => ChangeNotifierProvider.value(
                key: ValueKey(e),
                value: e,
                child: DraggableApp(
                    onTapDown: () {
                      runningAppsProvider.focusApp(e);
                    },),
              ))
          .toList(),
    );
  }
}
