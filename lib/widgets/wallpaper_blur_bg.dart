import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/widgets/blend_mask.dart';

class WallpaperBlurBg extends StatelessWidget {
  final Rect rect;

  const WallpaperBlurBg({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          Positioned(
              // top: 0,
              // left: 0,
              top: -rect.top,
              left: -rect.left,
              child: SizedBox(
                width: context.screenSize.width,
                height: context.screenSize.height,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Image.asset(
                      'assets/images/wall_${context.isDark ? 'dark' : 'light'}.jpg',
                      fit: BoxFit.cover),
                ),
              )),
          Positioned.fill(
              child: Container(color: const Color(0xFF1F282E).withOpacity(.8))),
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
    );
  }
}
