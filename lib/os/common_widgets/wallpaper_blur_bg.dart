import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/os/common_widgets/blend_mask.dart';
import 'package:flutter_windows_11_clone/os/controllers/wallpaper_controller.dart';
import 'package:provider/provider.dart';

class WallpaperBlurBg extends StatelessWidget {
  final Rect rect;

  const WallpaperBlurBg({super.key, required this.rect});

  @override
  Widget build(BuildContext context) {
    final blurredWallpaper = context.watch<WallpaperWrapper>().blurredWallpaper;
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
                child: Image(
                    image: blurredWallpaper.image,
                    fit: BoxFit.cover),
              )),
          Positioned.fill(
            child: BlendMask(
              blendMode: BlendMode.overlay,
              opacity: 1,    child: Container(
                color: const Color(0xff888888).withOpacity(0.96)),
            ),
          ),
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
