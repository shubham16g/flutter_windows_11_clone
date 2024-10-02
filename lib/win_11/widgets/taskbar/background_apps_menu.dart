import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';

import '../../common_widgets/custom_overlay_animated.dart';
import '../../common_widgets/glass_button.dart';

class BackgroundAppsMenu extends StatelessWidget
    implements PreferredSizeWidget {
  const BackgroundAppsMenu({super.key});

  @override
  Size get preferredSize => const Size(360, 394);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BackgroundAppsMenuButton extends StatelessWidget {
  const BackgroundAppsMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOverlayAnimated(
        useBarrier: false,
        offset: const Offset(0, -4),
        exitAnim: CustomOverlayAnim.slide,
        barrierColor: Colors.transparent,
        overlayBuilder: (context) => const BackgroundAppsMenu(),
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
