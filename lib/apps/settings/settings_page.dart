import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/main.dart';
import 'package:provider/provider.dart';

import '../../os/app/widgets/appbar_corner_buttons.dart';
import '../../os/common_widgets/wallpaper_blur_bg.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WallpaperBlurBg(rect: context.watch()),
        const Positioned(
            top: 0,
            right: 0,
            child: AppbarCornerButtons()),
      ],
    );
  }
}
