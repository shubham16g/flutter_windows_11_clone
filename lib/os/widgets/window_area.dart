import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/glass_blur_bg.dart';
import 'package:flutter_windows_11_clone/os/controllers/running_apps_controller.dart';
import 'package:provider/provider.dart';

import '../app/widgets/draggable_app.dart';

class WindowArea extends StatelessWidget {
  const WindowArea({super.key});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsProvider>();
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
          .toList() + [
            Padding(
              padding: const EdgeInsets.only(bottom: 47),
              child: ClipRRect(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment(0, runningAppsProvider.isStartMenuOpened ? 1 : 8),
                  child: Container(
                    width: 400,
                    height: 500,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: GlassBlurBg(),
                  ),
                ),
              ),
            )
      ],
    );
  }
}
