import 'package:flutter/material.dart';
import 'package:os_core/os_core.dart';
import 'package:os_core/src/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class StartMenu extends StatelessWidget {
  final PreferredSizeWidget startMenu;

  const StartMenu({super.key, required this.startMenu});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsController>();
    final screenHeight = context.screenSize.height - 48;
    final double height = screenHeight > startMenu.preferredSize.height
        ? startMenu.preferredSize.height
        : screenHeight;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      left: 0,
      right: 0,
      bottom: runningAppsProvider.isStartMenuOpened ? 0 : -height - 13 - 20,
      child: Center(
        child: Container(
          width: startMenu.preferredSize.width,
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 13),
          child: startMenu,
        ),
      ),
    );
  }
}
