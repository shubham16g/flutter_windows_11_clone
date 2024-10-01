import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_blur_bg.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_button.dart';

import '../../common_widgets/custom_overlay.dart';

class StartMenuFooter extends StatelessWidget {
  const StartMenuFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomOverlay(
          barrierColor: Colors.transparent,
          offset: const Offset(-30, -3),
          builder: (context, callback) {
            return GlassButton(
              showOutline: false,
              builder: (context, _) => const Text('Account'),
              onPressed: () {
                callback.showOverlay();
              },
            );
          },
          overlayBuilder: (context) {
            return const PreferredSize(
              preferredSize: Size(350, 220),
              child: GlassBlurBg(),
            );
          },
        ),
        CustomOverlay(
          barrierColor: Colors.transparent,
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          builder: (context, callback) {
            return GlassButton(
              showOutline: false,
              padding: EdgeInsets.zero,
              width: 40,
              height: 40,
              builder: (context, _) => const Icon(FluentIcons.power_button),
              onPressed: () {
                callback.showOverlay();
              },
            );
          },
          overlayBuilder: (context) {
            return const PreferredSize(
              preferredSize: Size(130, 160),
              child: GlassBlurBg(),
            );
          },
        ),
      ],
    ).pad(horizontal: 48, bottom: 10);
  }
}
