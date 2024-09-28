import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/wallpaper_blur_bg.dart';
import 'package:flutter_windows_11_clone/os/controllers/app_controller.dart';
import 'package:provider/provider.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool blurBackground;
  final List<BoxShadow>? boxShadow;
  final Rect? rect;
  final double borderRadius;

  const AppBackground({
    super.key,
    required this.child,
    this.blurBackground = false,
    this.rect,
    this.borderRadius = 8,
    this.boxShadow,
  }) : assert(!blurBackground || rect != null);

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AppController>();
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: context.osColor.appBackground,
        border: c.isFullScreen
            ? null
            : Border.all(color: context.osColor.appBorder, width: 1),
        borderRadius: BorderRadius.circular(c.isFullScreen ? 0 : borderRadius),
        boxShadow: c.isFocused
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
            BorderRadius.circular(c.isFullScreen ? 0 : borderRadius + 1),
        child: Stack(
          children: [
            if (blurBackground)
              WallpaperBlurBg(
                  rect: rect!, isFocused: c.isFocused || c.isFullScreenAnim),
            child,
          ],
        ),
      ),
    );
  }
}
