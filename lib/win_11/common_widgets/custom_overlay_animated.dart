import 'package:flutter/material.dart';

import 'custom_overlay.dart';
import 'slide_anim_wrapper.dart';

class CustomOverlayAnimated extends StatelessWidget {
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final bool barrierDismissible;
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
    this.barrierColor,
    required this.overlayBuilder,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 150);
    const curve = Curves.easeOutCubic;
    return CustomOverlay(
      closeDelay: duration,
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
      offset: offset,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      overlayBuilder: (context, isOpened) {
        final widget = overlayBuilder(context);
        return PreferredSize(
          preferredSize: widget.preferredSize,
          child: AnimatedOpacity(
            duration: duration,
            curve: curve,
            opacity: isOpened ? 1 : 0,
            child: SlideAnimWrapper(
              from: 0.6,
              duration: duration,
              curve: curve,
              opened: true,
              child: widget,
            ),
          ),
        );
      },
      builder: builder,
    );
  }
}
