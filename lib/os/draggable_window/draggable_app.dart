import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import 'app_controller.dart';

class DraggableApp extends StatelessWidget {
  final Widget child;
  final double? blur;
  final Color? backgroundColor;
  final VoidCallback? onTapDown;
  final Border? border;

  const DraggableApp(
      {super.key,
      required this.child,
        this.border,
      this.backgroundColor,
      this.blur,
      this.onTapDown});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AppController>();
    return AnimatedPositioned(
        duration:  Duration(milliseconds: c.isFullScreenAnim ? 300 : 0),
        curve: Curves.easeOutCubic,
        top: c.isFullScreen ? 0 : c.top,
        left: c.isFullScreen ? 0 : c.left,
        child: MouseRegion(
          onEnter: c.onHoverEnter,
          onHover: c.onHover,
          onExit: c.onHoverExit,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
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
            onDoubleTapDown: c.onDoubleTapDown,
            child: AnimatedContainer(
              duration:  Duration(milliseconds: c.isFullScreenAnim ? 300 : 0),
              curve: Curves.easeOutCubic,
              width: c.isFullScreen ? context.screenSize.width : c.width,
              height: c.isFullScreen ? context.screenSize.height : c.height,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: blur ?? 0, sigmaY: blur ?? 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: border,
                    ),
                      child: child),
                ),
              ),
            ),
          ),
        ));
  }
}
