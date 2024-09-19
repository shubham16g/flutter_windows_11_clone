import 'dart:math';
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
    return Positioned(
        top: c.top,
        left: c.left,
        child: MouseRegion(
          onHover: c.onHover,
          cursor: c.cursor,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: onTapDown == null
                ? null
                : (details) {
                    onTapDown!();
                  },
            onPanDown: (details) {
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
            child: Container(
              width: max(c.width, c.minWidth),
              height: max(c.height, c.minHeight),
              padding: const EdgeInsets.only(bottom: 8, top: 5),
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
