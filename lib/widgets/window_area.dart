import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/main.dart';
import 'package:flutter_windows_11_clone/os/draggable_window/draggable_app.dart';
import 'package:flutter_windows_11_clone/providers/running_apps_provider.dart';
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
                value: e,
                child: DraggableApp(
                    child: Stack(
                      children: [
                        GrainBlurBg(),
                        runningAppsProvider.runningAppsWidgets[
                        runningAppsProvider.runningAppsControllers.indexOf(e)]
                      ],
                    )),
              ))
          .toList(),
    );
  }
}
