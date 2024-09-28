import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        border: c.isFullScreen
            ? null
            : Border.all(
                color: const Color(0xFF757575).withOpacity(0.6), width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: c.isFocused
            ? boxShadow ?? [
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
            if (blurBackground) WallpaperBlurBg(rect: rect!, isFocused: c.isFocused || c.isFullScreenAnim),
            child,
          ],
        ),
      ),
    );
  }
}
