import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/apps/settings/settings_page.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

class GlassBlurBg extends StatelessWidget {
  const GlassBlurBg({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: isDark ? 50 : 50, sigmaY: isDark ? 50 : 50),
        child: Container(
          color: isDark
              ? Color.lerp(const Color(0xFF202020),
                      context.watch<WallpaperController>().dominantColor, 0.03)
                  ?.withOpacity(.6)
              : const Color(0xFFFFFFFF).withOpacity(.86),
          child: child,
        ),
      ),
    );
  }
}

extension GlassBlurBgExtension on Widget {
  Widget glassBlurBg() => GlassBlurBg(child: this);
}
