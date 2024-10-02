import 'package:flutter/material.dart';

class CustomOverlayCallback {
  final OverlayEntry overlayEntry;
  final OverlayState overlayState;
  final Duration? closeDelay;
  bool opened = false;
  Key? _openKey;

  CustomOverlayCallback({
    required this.overlayEntry,
    required this.overlayState,
    this.closeDelay,
  });

  bool get mounted => overlayEntry.mounted;

  void showOverlay() {
    opened = true;
    _openKey = UniqueKey();
    overlayState.insert(overlayEntry);
  }

  Future<void> hideOverlay() async {
    opened = false;
    overlayEntry.markNeedsBuild();
    final closeKey = _openKey;
    if (closeDelay != null) {
      await Future.delayed(closeDelay!);
    }
    if (mounted && closeKey == _openKey) {
      overlayEntry.remove();
    }
  }

  void removeOverlay() {
    if (mounted) {
      overlayEntry.remove();
    }
  }
}

class CustomOverlay extends StatefulWidget {
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final bool barrierDismissible;
  final Color? barrierColor;
  final Duration? closeDelay;
  final PreferredSizeWidget Function(BuildContext context, bool opened)
      overlayBuilder;
  final Widget Function(BuildContext context, CustomOverlayCallback callback)
      builder;

  const CustomOverlay({
    super.key,
    this.offset = Offset.zero,
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.bottomLeft,
    this.barrierDismissible = true,
    this.closeDelay,
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
        closeDelay: widget.closeDelay,
        overlayEntry: buildOverlay(),
        overlayState: Overlay.of(context));
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    overlayCallback.removeOverlay();
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
        final overlay = widget.overlayBuilder(context, overlayCallback.opened);
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.barrierDismissible
                      ? () async {
                          if (mounted) {
                            overlayCallback.hideOverlay();
                          }
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
