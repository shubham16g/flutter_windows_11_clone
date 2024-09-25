import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';

import 'blend_mask.dart';

class GlassBlurBg extends StatelessWidget {
  const GlassBlurBg({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Stack(
          children: [
            Positioned.fill(
              child: BlendMask(
                blendMode: BlendMode.multiply,
                opacity: 1,
                child:
                    Container(color: const Color(0xFF6A6A6A).withOpacity(0.96)),
              ),
            ),
            Positioned.fill(
                child: BlendMask(
                    blendMode: BlendMode.overlay,
                    opacity: 0.5,
                    child: Container(
                        color: const Color(0xFFF1F1F1).withOpacity(0.96)))),
            Positioned.fill(
                child:
                    Container(color: isDark ? const Color(0xFF373737).withOpacity(.4) : const Color(
                        0xFFFFFFFF).withOpacity(.4))),
            Positioned.fill(
              child: Opacity(
                opacity: 0.02,
                child: Image.asset(
                  'assets/images/NoiseAsset_256.png',
                  repeat: ImageRepeat.repeat,
                  alignment: Alignment.topLeft,
                  // repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
