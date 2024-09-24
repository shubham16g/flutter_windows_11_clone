import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import 'app_controller.dart';

class DraggableApp extends StatelessWidget {
  final double? blur;
  final Color? backgroundColor;
  final VoidCallback? onTapDown;
  final Border? border;

  const DraggableApp(
      {super.key,
      this.border,
      this.backgroundColor,
      this.blur,
      this.onTapDown});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AppController>();
    final width = c.isFullScreen ? context.screenSize.width : c.width;
    final height = c.isFullScreen ? context.screenSize.height : c.height;
    final double top = c.isFullScreen ? 0 : c.top;
    final double left = c.isFullScreen ? 0 : c.left;
    return AnimatedPositioned(
        duration: Duration(milliseconds: c.isFullScreenAnim ? 300 : 0),
        curve: Curves.easeOutCubic,
        top: c.isMinimized
            ? context.screenSize.height
            : top,
        left: c.isMinimized
            ? (context.screenSize.width / 2 - 20)
            : left,
        child: MouseRegion(
          onEnter: c.onHoverEnter,
          onHover: c.onHover,
          onExit: c.onHoverExit,
          child: GestureDetector(
            onTapDown: onTapDown == null
                ? null
                : (details) {
                    onTapDown!();
                  },
            onPanDown: (details) {
              onTapDown?.call();
              c.panStart(details);
            },
            onPanEnd: (details) {
              c.panEnd(context.screenSize);
            },
            onPanCancel: () {
              c.panEnd(context.screenSize);
            },
            onPanUpdate: (details) {
              // if drag from sides, change width or height
              c.onPanUpdate(details.delta.dx, details.delta.dy,
                  details.localPosition.dx, details.localPosition.dy);
            },
            child: Builder(
              builder: (context) {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: c.isOpenClose ? 200 : 0),
                  opacity: c.isOpenClose ? 0 : 1,
                  curve: Curves.easeIn,
                  child: AnimatedScale(
                    duration: Duration(
                        milliseconds: c.isFullScreenAnim
                            ? 300
                            : (c.isOpenCloseAnim ? 200 : 0)),
                    curve: c.isOpenClose ? Curves.easeIn : Curves.easeOutCubic,
                    scale: c.isMinimized ? 0 : (c.isOpenClose ? 0.9 : 1),
                    alignment:
                        c.isFullScreenAnim ? Alignment.topLeft : Alignment.center,
                    child: AnimatedContainer(
                      duration:
                          Duration(milliseconds: c.isFullScreenAnim ? 300 : 0),
                      curve: Curves.easeOutCubic,
                      width: width,
                      height: height,
                      child: c.app.builder(
                          context, Rect.fromLTWH(left, top, width, height)),
                    ),
                  ),
                );
              }
            ),
          ),
        ));
  }
}
