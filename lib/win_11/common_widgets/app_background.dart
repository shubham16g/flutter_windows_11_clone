import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';

import 'glass_blur_bg.dart';
import 'wallpaper_blur_bg.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool wallpaperBlur;
  final bool glassBlur;
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
    this.wallpaperBlur = false,
    this.glassBlur = false,
    this.rect,
    this.borderRadius = 8,
    this.boxShadow,
    this.backgroundColor,
    this.isFullScreen = false,
    this.isFocused = true,
    this.borderColor,
  }) : assert(!wallpaperBlur || rect != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: glassBlur
            ? Colors.transparent
            : backgroundColor ?? context.osColor.appBackground,
        border: isFullScreen
            ? null
            : Border.all(
                color: borderColor ??
                    (glassBlur
                        ? context.osColor.taskbarBorder
                        : context.osColor.appBorder),
                width: 1),
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
        borderRadius: BorderRadius.circular(isFullScreen ? 0 : borderRadius),
        child: Stack(
          children: [
            if (glassBlur)
              const GlassBlurBg()
            else if (wallpaperBlur)
              WallpaperBlurBg(rect: rect!, isFocused: isFocused),
            child,
          ],
        ),
      ),
    );
  }
}
