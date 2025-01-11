import 'package:flutter/material.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

class WindowArea extends StatelessWidget {
  const WindowArea({super.key});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<OsAppsController>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap:() {
        runningAppsProvider.clearAppFocus();
      },
      child: Stack(
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
      ),
    );
  }
}
