import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/apps/settings/settings_page.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import 'blend_mask.dart';

class GlassBlurBg extends StatelessWidget {
  const GlassBlurBg({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: isDark ? 50 : 50, sigmaY: isDark ? 50 : 50),
        child: Stack(
          children: [
            // Positioned.fill(
            //   child: BlendMask(
            //     opacity: 0.8,
            //     blendMode: BlendMode.multiply,
            //     child: Image.asset(
            //       'assets/images/NoiseAsset_256.png',
            //       repeat: ImageRepeat.repeat,
            //       alignment: Alignment.topLeft,
            //       color: isDark
            //           ? Color.lerp(const Color(0xFF373737),
            //               context.watch<WallpaperWrapper>().dominantColor, 0.6)
            //           : const Color(0xFFF1F1F1),
            //       // repeat: ImageRepeat.repeat,
            //     ),
            //   ),
            // ),
            // if (isDark)
            // Positioned.fill(
            //   child: BlendMask(
            //     blendMode: BlendMode.multiply,
            //     opacity: 1,
            //     child:
            //         Container(color: const Color(0xFF6A6A6A).withOpacity(0.96)),
            //   ),
            // ),
            // if (isDark)
            //   Positioned.fill(
            //     child: BlendMask(
            //         blendMode: BlendMode.overlay,
            //         opacity: 0.5,
            //         child: Container(
            //             color: const Color(0xFFF1F1F1).withOpacity(0.96)))),
            Positioned.fill(
                child: Container(
                    color: isDark
                        ? Color.lerp(const Color(0xFF202020),
                                       context.watch<WallpaperController>().dominantColor, 0.03)?.withOpacity(.6)
                        : const Color(0xFFFFFFFF).withOpacity(.8))),

          ],
        ),
      ),
    );
  }
}
