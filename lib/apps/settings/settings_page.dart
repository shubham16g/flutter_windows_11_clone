import 'package:flutter/material.dart';

import '../../os/app/widgets/appbar_corner_buttons.dart';
import '../../os/common_widgets/wallpaper_blur_bg.dart';

class SettingsPage extends StatelessWidget {
  final Rect rect;
  const SettingsPage({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WallpaperBlurBg(rect: rect),
        const Positioned(
            top: 0,
            right: 0,
            child: AppbarCornerButtons()),
      ],
    );
  }
}
