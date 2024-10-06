import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/app_background.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_blur_bg.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_button.dart';

import '../../common_widgets/custom_overlay.dart';
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
                    child: Icon(FluentIcons.contact,
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
              child: const Icon(FluentIcons.power_button),
              onPressed: () {
                callback.showOverlay();
              },
            );
          },
          overlayBuilder: (context) {
            return const PreferredSize(
              preferredSize: Size(130, 160),
              child: AppBackground(
                  glassBlur: true,
                  boxShadow: [],
                  borderColor: Colors.transparent,
                  child: SizedBox()),
            );
          },
        ),
      ],
    ).pad(horizontal: 48, bottom: 10);
  }
}
