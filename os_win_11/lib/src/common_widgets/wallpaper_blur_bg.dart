import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:os_win_11/src/utils/ui_utils.dart';
import 'package:os_win_11/src/colors/os_extension_on_colors.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

class WallpaperBlurBg extends StatelessWidget {
  final Rect? rect;
  final bool isFocused;

  const WallpaperBlurBg({super.key, this.rect, this.isFocused = true});

  @override
  Widget build(BuildContext context) {
    final wallpaperController = context.watch<WallpaperController>();
    final blurredWallpaper = wallpaperController.blurredWallpaper;
    final isDark = context.isDark;
    return XYZBuilder(
      rect: rect,
        builder: (context, rect) {
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
                    child: FadeInImage(
                        placeholder: blurredWallpaper.image,
                        image: blurredWallpaper.image,
                        fit: BoxFit.cover),
                  )),
            Positioned.fill(
                child: Container(
                    color: isDark
                        ? Color.lerp(const Color(0xFF202020),
                                wallpaperController.dominantColor, 0.06)
                            ?.withOpacity(.65)
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
                child: Container(color: context.osColor.appBackground),
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
    });
  }
}

class XYZBuilder extends StatefulWidget {
  final Rect? rect;
  final Widget Function(BuildContext context, Rect rect) builder;

  const XYZBuilder({Key? key, required this.builder, this.rect})
      : super(key: key);

  @override
  _XYZBuilderState createState() => _XYZBuilderState();
}

class _XYZBuilderState extends State<XYZBuilder>
    with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  Rect _rect = Rect.zero;

   Ticker? _ticker;

  @override
  void initState() {
    super.initState();
    if (widget.rect == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateRect());
      _ticker = Ticker((_) => _updateRect())..start();
    }
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }

  void _updateRect() {
    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      final Rect newRect = Rect.fromLTWH(
        offset.dx,
        offset.dy,
        renderBox.size.width,
        renderBox.size.height,
      );

      if (_rect != newRect) {
        debugPrint('update rect');
        setState(() {
          _rect = newRect;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.builder(context, widget.rect ?? _rect),
    );
  }
}
