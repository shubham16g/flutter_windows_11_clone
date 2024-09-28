import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/app_background.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';

import '../../os/app/widgets/appbar_corner_buttons.dart';

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
          Positioned(
              top: 0,
              right: 0,
              child: AppbarCornerButtons(
                isDark: context.isDark,
              )),
        ],
      ),
    );
  }
}
