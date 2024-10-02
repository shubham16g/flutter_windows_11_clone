import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';

class CustomOverlay extends StatefulWidget {
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final bool barrierDismissible;
  final bool useBarrier;
  final Color? barrierColor;
  final EdgeInsets screenSideMargin;
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
    this.useBarrier = false,
    this.closeDelay,
    this.screenSideMargin = const EdgeInsets.all(16),
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
  final GlobalKey _key = GlobalKey();

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
    overlayCallback.removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      overlayCallback.notify();
    });

    return CompositedTransformTarget(
      link: layerLink,
      child:
          SizedBox(key: _key, child: widget.builder(context, overlayCallback)),
    );
  }

  Rect getRect(PreferredSizeWidget overlay) {
    final rect = _key.globalPaintBounds ?? Rect.zero;
    final targetAnchor = widget.targetAnchor;
    final followerAnchor = widget.followerAnchor;
    final w = rect.width / 2;
    final h = rect.height / 2;
    final pw = overlay.preferredSize.width / 2;
    final ph = overlay.preferredSize.height / 2;
    final targetPointX =
        rect.left + w + w * targetAnchor.x - pw - pw * followerAnchor.x;
    final targetPointY =
        rect.top + h + h * targetAnchor.y - ph - ph * followerAnchor.y;
    final newOffset = Offset(targetPointX, targetPointY);

    final offset = repositionInsideScreen(
        context.screenSize,
        overlay.preferredSize,
        Offset(
            newOffset.dx + widget.offset.dx, newOffset.dy + widget.offset.dy),
        margin: widget.screenSideMargin);
    return Rect.fromLTWH(offset.dx, offset.dy, overlay.preferredSize.width,
        overlay.preferredSize.height);
  }

  OverlayEntry buildOverlay() => OverlayEntry(builder: (_) {
        final overlay = widget.overlayBuilder(context, overlayCallback.opened);
        final rect = getRect(overlay);
        final offset = rect.topLeft;
        return Stack(
          children: [
            if (widget.useBarrier)
              Positioned.fill(
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: widget.barrierDismissible
                        ? (_) {
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
              )
            else
              Positioned.fill(
                  child: Listener(
                      behavior: HitTestBehavior.translucent,
                      onPointerDown: (details) {
                        overlayCallback.hideOverlay();
                      })),
            Positioned(
              top: offset.dy,
              left: offset.dx,
              width: overlay.preferredSize.width,
              height: overlay.preferredSize.height,
              child: overlay,
            ),
          ],
        );
      });

  Offset repositionInsideScreen(
      Size screenSize, Size widgetSize, Offset topLeft,
      {EdgeInsets margin = const EdgeInsets.all(16)}) {
    final top = topLeft.dy;
    final left = topLeft.dx;
    final bottom = top + widgetSize.height;
    final right = left + widgetSize.width;

    final topOffset = top < margin.top ? -top + margin.top : 0;
    final leftOffset = left < margin.left ? -left + margin.left : 0;
    final bottomOffset = bottom > screenSize.height - margin.bottom
        ? screenSize.height - bottom - margin.bottom
        : 0;
    final rightOffset = right > screenSize.width - margin.right
        ? screenSize.width - right - margin.right
        : 0;

    return Offset(
        left + leftOffset + rightOffset, top + topOffset + bottomOffset);
  }
}

class CustomOverlayCallback {
  final OverlayEntry overlayEntry;
  final OverlayState overlayState;
  final Duration? closeDelay;
  bool opened = false;

  CustomOverlayCallback({
    required this.overlayEntry,
    required this.overlayState,
    this.closeDelay,
  });

  bool get mounted => overlayEntry.mounted;

  void showOverlay() {
    opened = true;
    overlayState.insert(overlayEntry);
  }

  Future<void> hideOverlay() async {
    opened = false;
    overlayEntry.markNeedsBuild();
    final overlayEn = overlayEntry;
    if (closeDelay != null) {
      await Future.delayed(closeDelay!);
    }
    if (overlayEn.mounted) {
      overlayEn.remove();
    }
  }

  void notify() {
    overlayEntry.markNeedsBuild();
  }

  void removeOverlay() {
    if (mounted) {
      overlayEntry.remove();
    }
  }
}
