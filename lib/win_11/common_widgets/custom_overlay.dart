import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';

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

  void notify() {
    overlayEntry.markNeedsBuild();
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
  final bool useBarrier;
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
    this.useBarrier = true,
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

  OverlayEntry buildOverlay() => OverlayEntry(builder: (_) {
        final overlay = widget.overlayBuilder(context, overlayCallback.opened);
        final rect = _key.globalPaintBounds ?? Rect.zero;
        final newOffset = rect.topLeft + widget.offset;
        final offset = repositionInsideScreen(
            context.screenSize,
            overlay.preferredSize,
            Offset(newOffset.dx, newOffset.dy - overlay.preferredSize.height));

        return Stack(
          children: [
            if (widget.useBarrier)
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
              top: offset.dy,
              left: offset.dx,
              width: overlay.preferredSize.width,
              height: overlay.preferredSize.height,
              child: overlay,
            ),
            Text('Screen: ${context.screenSize}')
          ],
        );
      });

  Offset repositionInsideScreen(
      Size screenSize, Size widgetSize, Offset topLeft, {double margin = 0}) {
    final top = topLeft.dy;
    final left = topLeft.dx;
    final bottom = top + widgetSize.height;
    final right = left + widgetSize.width;

    final topOffset = top < 0 ? -top : 0;
    final leftOffset = left < 0 ? -left : 0;
    final bottomOffset =
        bottom > screenSize.height ? screenSize.height - bottom : 0;
    final rightOffset = right > screenSize.width ? screenSize.width - right : 0;

    return Offset(
        left + leftOffset + rightOffset, top + topOffset + bottomOffset);
  }
}
