import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';

import '../../common_widgets/app_background.dart';
import '../../common_widgets/custom_overlay_animated.dart';
import '../../common_widgets/glass_button.dart';

class TaskbarBackgroundAppsMenu extends StatelessWidget
    implements PreferredSizeWidget {
  final List<String> items;

  const TaskbarBackgroundAppsMenu({super.key, required this.items});

  final bottomMargin = 16.0;
  final itemSize = 40;
  final padding = 3;
  final itemInRow = 5;

  @override
  Size get preferredSize => Size(
      items.length < itemInRow
          ? items.length * itemSize + padding * 2
          : itemInRow * itemSize + padding * 2,
      (items.length / itemInRow).ceil() * itemSize +
          padding * 2 +
          bottomMargin);

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
      borderColor: Colors.transparent,
      boxShadow: [],
      glassBlur: true,
      child: SizedBox(),
    ).pad(bottom: bottomMargin);
  }
}

class TaskbarBackgroundAppsMenuButton extends StatelessWidget {
  const TaskbarBackgroundAppsMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOverlayAnimated(
        useBarrier: false,
        offset: const Offset(0, -4),
        targetAnchor: Alignment.topCenter,
        followerAnchor: Alignment.bottomCenter,
        exitAnim: CustomOverlayAnim.slide,
        barrierColor: Colors.transparent,
        decoration: BoxDecoration(
          boxShadow: AppBackground.defaultBoxShadow(context),
        ),
        overlayBuilder: (context) => TaskbarBackgroundAppsMenu(items: ['', '', '', '', '', ''],),
        builder: (context, callback) {
          return GlassButton(
            height: 40,
            width: 34,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            onPressed: () {
              callback.showOverlay();
            },
            child: const Icon(FluentIcons.chevron_up_med, size: 12),
          );
        });
  }
}
