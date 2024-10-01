import 'package:flutter/material.dart';

class CustomOverlayCallback {
  final OverlayEntry overlayEntry;
  final OverlayState overlayState;

  CustomOverlayCallback(
      {required this.overlayEntry, required this.overlayState});

  bool get mounted => overlayEntry.mounted;
  void showOverlay() {
    overlayState.insert(overlayEntry);
  }

  void hideOverlay() {
    overlayEntry.mounted ? overlayEntry.remove() : null;
  }
}

class CustomOverlay extends StatefulWidget {
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final bool barrierDismissible;
  final Color? barrierColor;
  final PreferredSizeWidget Function(BuildContext context) overlayBuilder;
  final Widget Function(BuildContext context, CustomOverlayCallback callback)
      builder;

  const CustomOverlay({
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
  State<CustomOverlay> createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay> {
  late final CustomOverlayCallback overlayCallback;
  final layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    overlayCallback = CustomOverlayCallback(
        overlayEntry: buildOverlay(), overlayState: Overlay.of(context));
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    overlayCallback.hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: widget.builder(context, overlayCallback),
    );
  }

  buildOverlay() => OverlayEntry(builder: (_) {
        final overlay = widget.overlayBuilder(context);
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.barrierDismissible
                      ? () {
                          overlayCallback.hideOverlay();
                        }
                      : null,
                  child: IgnorePointer(
                    child: Container(
                        color: widget.barrierColor ??
                            Colors.black.withOpacity(0.4)),
                  )), // Transparent background to detect taps
            ),
            Positioned(
              width: overlay.preferredSize.width,
              height: overlay.preferredSize.height,
              child: CompositedTransformFollower(
                link: layerLink,
                targetAnchor: widget.targetAnchor,
                followerAnchor: widget.followerAnchor,
                offset: widget.offset,
                showWhenUnlinked: false,
                child: overlay,
              ),
            ),
          ],
        );
      });
}
