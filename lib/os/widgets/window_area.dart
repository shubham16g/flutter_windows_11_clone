import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/main.dart';
import 'package:flutter_windows_11_clone/os/app/widgets/draggable_app.dart';
import 'package:flutter_windows_11_clone/os/controllers/running_apps_controller.dart';
import 'package:flutter_windows_11_clone/os/app/widgets/appbar_corner_buttons.dart';
import 'package:flutter_windows_11_clone/widgets/grain_blur_bg.dart';
import 'package:provider/provider.dart';

class WindowArea extends StatelessWidget {
  const WindowArea({super.key});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsProvider>();
    return Stack(
      children: runningAppsProvider.runningAppsControllers
          .map((e) => ChangeNotifierProvider.value(
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
