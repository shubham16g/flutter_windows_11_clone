import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';

import '../../common_widgets/custom_overlay_animated.dart';
import '../../common_widgets/glass_button.dart';

class ControlMenu extends StatelessWidget implements PreferredSizeWidget {
  const ControlMenu({super.key});

  @override
  Size get preferredSize => const Size(360, 394);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ControlMenuButton extends StatelessWidget {
  const ControlMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOverlayAnimated(
        useBarrier: false,
        offset: const Offset(0, -4),
        exitAnim: CustomOverlayAnim.slide,
        barrierColor: Colors.transparent,
        overlayBuilder: (context) => const ControlMenu(),
        builder: (context, callback) {
          return GlassButton(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            onPressed: () {
              callback.showOverlay();
            },
            child: IconTheme(
              data: context.theme.iconTheme.copyWith(size: 15),
              child: const Row(
                children: [
                  Icon(FluentIcons.internet_sharing),
                  SizedBox(width: 8),
                  Icon(FluentIcons.volume3),
                  SizedBox(width: 8),
                  Icon(FluentIcons.lightning_secure),
                ],
              ),
            ),
          );
        });
  }
}

