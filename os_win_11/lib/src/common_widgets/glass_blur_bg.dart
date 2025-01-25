import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:os_win_11/src/common_widgets/wallpaper_blur_bg.dart';
import 'package:os_win_11/src/utils/ui_utils.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import 'blend_mask.dart';

class GlassBlurBg extends StatelessWidget {
  const GlassBlurBg({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (child == null)
      return WallpaperBlurBg();
    else
      return Stack(
        children: [WallpaperBlurBg(), child!],
      );
    final isDark = context.isDark;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: isDark ? 50 : 50, sigmaY: isDark ? 50 : 50),
        child: true
            ? Container(
                color: isDark
                    ? Color.lerp(
                            const Color(0xFF202020),
                            context.watch<WallpaperController>().dominantColor,
                            0.03)
                        ?.withOpacity(.6)
                    : const Color(0xFFFFFFFF).withOpacity(.86),
                child: child,
              )
            : Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                          color: isDark
                              ? Color.lerp(
                                      const Color(0xFF202020),
                                      context
                                          .watch<WallpaperController>()
                                          .dominantColor,
                                      0.03)
                                  ?.withOpacity(.6)
                              : const Color(0xFFFFFFFF).withOpacity(.86))),
                  if (child != null) Positioned.fill(child: child!),
                ],
              ),
      ),
    );
  }
}

extension GlassBlurBgExtension on Widget {
  Widget glassBlurBg() => GlassBlurBg(child: this);
}
