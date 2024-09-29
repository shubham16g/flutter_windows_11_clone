import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/app_background.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import '../common_widgets/glass_blur_bg.dart';
import '../controllers/running_apps_controller.dart';

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final runningAppsProvider = context.watch<RunningAppsController>();
    final screenHeight = context.screenSize.height - 48;
    final double height = screenHeight - 26 > 726 ? 726 : screenHeight - 26;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      left: 0,
      right: 0,
      bottom: runningAppsProvider.isStartMenuOpened ? 0 : -height - 13 - 20,
      child: Center(
        child: Container(
          width: 642,
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 13),
          child: AppBackground(
            borderColor: context.osColor.taskbarBorder,
            isFocused: true,
            isFullScreen: false,
            backgroundColor: Colors.transparent,
              child: const GlassBlurBg()),
        ),
      ),
    );
  }
}
