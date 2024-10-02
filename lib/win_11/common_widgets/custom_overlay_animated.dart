import 'package:flutter/material.dart';

import 'custom_overlay.dart';
import 'slide_anim_wrapper.dart';

/// this widget should be host on pub.dev

enum CustomOverlayAnim {
  fade,
  slide,
  fadeAndSlide,
}

class CustomOverlayAnimated extends StatelessWidget {
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final bool barrierDismissible;
  final bool useBarrier;
  final double openFrom;
  final CustomOverlayAnim exitAnim;
  final SlideAnimDirection slideAnimDirection;
  final EdgeInsets screenSideMargin;
  final Duration duration;
  final Curve curve;
  final Color? barrierColor;
  final PreferredSizeWidget Function(BuildContext context) overlayBuilder;
  final Widget Function(BuildContext context, CustomOverlayCallback callback)
      builder;

  const CustomOverlayAnimated({
    super.key,
    this.offset = Offset.zero,
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.bottomLeft,
    this.barrierDismissible = true,
    this.exitAnim = CustomOverlayAnim.fade,
    this.slideAnimDirection = SlideAnimDirection.bottom,
    this.screenSideMargin = const EdgeInsets.all(16),
    this.useBarrier = false,
    this.openFrom = 1,
    this.barrierColor,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeOutCubic,
    required this.overlayBuilder,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOverlay(
      closeDelay: duration,
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
      useBarrier: useBarrier,
      offset: offset,
      screenSideMargin: screenSideMargin,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      overlayBuilder: (context, isOpened) {
        final widget = overlayBuilder(context);
        return PreferredSize(
          preferredSize: widget.preferredSize,
          child: AnimatedOpacity(
            duration: duration,
            curve: curve,
            opacity: isOpened || exitAnim == CustomOverlayAnim.slide ? 1 : 0,
            child: SlideAnimWrapper(
              from: !isOpened ? 1 : openFrom,
              duration: duration,
              direction: slideAnimDirection,
              curve: curve,
              opened: exitAnim != CustomOverlayAnim.slide ? true : isOpened,
              child: widget,
            ),
          ),
        );
      },
      builder: builder,
    );
  }
}
