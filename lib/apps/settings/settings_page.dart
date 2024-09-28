import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/app_background.dart';

import '../../os/app/widgets/appbar_corner_buttons.dart';
import '../../os/common_widgets/wallpaper_blur_bg.dart';

class SettingsPage extends StatelessWidget {
  final Rect rect;
  const SettingsPage({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      blurBackground: true,
      rect: rect,
      child: Stack(
        children: [
          const Positioned(
              top: 0,
              right: 0,
              child: AppbarCornerButtons()),
        ],
      ),
    );
  }
}
