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
    return CustomOverlay(
      closeDelay: const Duration(milliseconds: 1150),
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
      offset: offset,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      overlayBuilder: (context) {
        final widget = overlayBuilder(context);
        return PreferredSize(
          preferredSize: widget.preferredSize,
          child: SlideAnimWrapper(
            from: 0.6,
            curve: Curves.easeOutCubic,
            duration: const Duration(milliseconds: 450),
            opened: true,
            child: widget,
          ),
        );
      },
      builder: builder,
    );
  }
}
