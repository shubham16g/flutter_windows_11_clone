import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';

import 'wallpaper_blur_bg.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool blurBackground;
  final List<BoxShadow>? boxShadow;
  final Rect? rect;
  final Color? borderColor;
  final double borderRadius;
  final Color? backgroundColor;
  final bool isFullScreen;
  final bool isFocused;

  const AppBackground({
    super.key,
    required this.child,
    this.blurBackground = false,
    this.rect,
    this.borderRadius = 8,
    this.boxShadow,
    this.backgroundColor,
    required this.isFullScreen,
    required this.isFocused,
    this.borderColor,
  }) : assert(!blurBackground || rect != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.osColor.appBackground,
        border: isFullScreen
            ? null
            : Border.all(
                color: borderColor ?? context.osColor.appBorder, width: 1),
        borderRadius: BorderRadius.circular(isFullScreen ? 0 : borderRadius),
        boxShadow: isFocused
            ? boxShadow ??
                [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 5))
                ]
            : null,
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(isFullScreen ? 0 : borderRadius),
        child: Stack(
          children: [
            if (blurBackground)
              WallpaperBlurBg(rect: rect!, isFocused: isFocused),
            child,
          ],
        ),
      ),
    );
  }
}
