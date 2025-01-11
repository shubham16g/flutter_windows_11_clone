
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:os_win_11/src/utils/ui_utils.dart';
import 'package:os_win_11/src/colors/os_extension_on_colors.dart';
import 'package:os_win_11/src/common_widgets/app_background.dart';
import 'package:os_win_11/src/common_widgets/glass_button.dart';

import '../../common_widgets/custom_overlay_animated.dart';

class StartMenuFooter extends StatelessWidget {
  const StartMenuFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomOverlayAnimated(
          barrierColor: Colors.transparent,
          offset: const Offset(-30, -4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppBackground.defaultBoxShadow(context),
          ),
          clipBehavior: Clip.antiAlias,
          builder: (context, callback) {
            return GlassButton(
              showOutline: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: context.osColor.appBackground,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.osColor.taskbarBorder.withOpacity(0.03),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(FluentIcons.person_6_20_filled,
                        color: context.osColor.textTertiary),
                  ),
                  const SizedBox(width: 12),
                  Text('Account',
                      style: context.theme.typography.caption?.copyWith(
                          color: context.osColor.textPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                ],
              ),
              onPressed: () {
                callback.showOverlay();
              },
            );
          },
          overlayBuilder: (context) {
            return const PreferredSize(
              preferredSize: Size(350, 220),
              child: AppBackground(
                  glassBlur: true,
                  boxShadow: [],
                  borderColor: Colors.transparent,
                  child: SizedBox()),
            );
          },
        ),
        CustomOverlayAnimated(
          barrierColor: Colors.transparent,
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          offset: const Offset(0, -4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppBackground.defaultBoxShadow(context),
          ),
          clipBehavior: Clip.antiAlias,
          builder: (context, callback) {
            return GlassButton(
              showOutline: false,
              padding: EdgeInsets.zero,
              width: 40,
              height: 40,
              child: const Icon(FluentIcons.power_24_regular),
              onPressed: () {
                callback.showOverlay();
              },
            );
          },
          overlayBuilder: (context) {
            return PreferredSize(
              preferredSize: const Size(120, 128),
              child: AppBackground(
                  glassBlur: true,
                  boxShadow: const [],
                  borderColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      children: [
                        _powerItem(context, FluentIcons.lock_closed_28_regular, 'Lock', () {}),
                        _powerItem(context, FluentIcons.sleep_20_regular, 'Sleep', () {}),
                        _powerItem(context, FluentIcons.power_20_regular, 'Shut down', () {}),
                        _powerItem(context, FluentIcons.history_20_regular, 'Restart', () {}),
                      ],
                    ),
                  )),
            );
          },
        ),
      ],
    ).pad(horizontal: 48, bottom: 10);
  }

  Widget _powerItem(BuildContext context, IconData iconData, String title,
      VoidCallback onTap) {
    return GlassButton(
        onPressed: onTap,
        showOutline: false,
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 8),
            Text(title,
                style: TextStyle(
                    color: context.osColor.textPrimary, fontSize: 14)),
          ],
        ));
  }
}
