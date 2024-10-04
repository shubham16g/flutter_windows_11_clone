
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/apps/apps.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';

import '../../common_widgets/app_background.dart';
import '../../common_widgets/custom_overlay_animated.dart';
import '../../common_widgets/glass_button.dart';

class TaskbarControlMenu extends StatelessWidget implements PreferredSizeWidget {
  const TaskbarControlMenu({super.key});

  final bottomMargin = 16.0;

  @override
  Size get preferredSize => Size(360, 394 + bottomMargin);

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
      glassBlur: true,
      child: SizedBox(),
    ).pad(bottom: bottomMargin);
  }
}

class TaskbarControlMenuButton extends StatelessWidget {
  const TaskbarControlMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOverlayAnimated(
        useBarrier: false,
        offset: const Offset(0, -4),
        exitAnim: CustomOverlayAnim.slide,
        barrierColor: Colors.transparent,
        overlayBuilder: (context) => const TaskbarControlMenu(),
        builder: (context, callback) {
          return GlassButton(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 4.5),
            onPressed: () {
              callback.showOverlay();
            },
            child: IconTheme(
              data: context.theme.iconTheme.copyWith(size: 20),
              child: const Row(
                children: [
                  Icon(FluentIcons.wifi_1_20_regular),
                  SizedBox(width: 4),
                  Icon(FluentIcons.speaker_2_20_regular),
                  SizedBox(width: 4),
                  Icon(FluentIcons.battery_5_20_regular),
                ],
              ),
            ),
          );
        });
  }
}

