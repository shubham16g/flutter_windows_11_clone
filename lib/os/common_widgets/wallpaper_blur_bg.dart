import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/os/controllers/wallpaper_controller.dart';
import 'package:provider/provider.dart';

import 'blend_mask.dart';

class WallpaperBlurBg extends StatelessWidget {
  final Rect rect;
  final bool isFocused;

  const WallpaperBlurBg({super.key, required this.rect, this.isFocused = true});

  @override
  Widget build(BuildContext context) {
    final wallpaperController = context.watch<WallpaperWrapper>();
    final blurredWallpaper = wallpaperController.blurredWallpaper;
    final isDark = context.isDark;
    return ClipRRect(
      child: Stack(
        children: [
          if (blurredWallpaper != null)
            Positioned(
              // top: 0,
              // left: 0,
                top: -rect.top,
                left: -rect.left,
                child: SizedBox(
                  width: context.screenSize.width,
                  height: context.screenSize.height,
                  child: FadeInImage( placeholder: blurredWallpaper.image,
                    image: blurredWallpaper.image,
                       fit: BoxFit.cover),
                )),
          Positioned.fill(
              child: Container(
                  color: isDark
                      ? Color.lerp(const Color(0xFF202020),
                      context.watch<WallpaperWrapper>().dominantColor, 0.06)?.withOpacity(.65)
                      : const Color(0xFFFFFFFF).withOpacity(.8))),
          // Positioned.fill(
          //   child: BlendMask(
          //     blendMode: BlendMode.colorBurn,
          //     opacity: 1,
          //     child: Container(
          //         color: wallpaperController.dominantColor.withOpacity(0.6)),
          //   ),
          // ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: isFocused ? 0.8 : 1,
              curve: Curves.ease,
              child: Container(
                  color: context.osColor.appBackground),
            ),
          ),
          // Positioned.fill(
          //   child: Opacity(
          //     opacity: 0.02,
          //     child: Image.asset(
          //       'assets/images/NoiseAsset_256.png',
          //       repeat: ImageRepeat.repeat,
          //       alignment: Alignment.topLeft,
          //       // repeat: ImageRepeat.repeat,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
