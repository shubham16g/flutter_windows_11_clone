import 'package:flutter/material.dart';

enum SlideAnimDirection {
  top,
  left,
  right,
  bottom;

  Alignment get alignment {
    switch (this) {
      case SlideAnimDirection.top:
        return Alignment.topCenter;
      case SlideAnimDirection.left:
        return Alignment.centerLeft;
      case SlideAnimDirection.right:
        return Alignment.centerRight;
      case SlideAnimDirection.bottom:
        return Alignment.bottomCenter;
    }
  }

  double? _sideValue(SlideAnimDirection dir) {
    return this == dir ? null : 0;
  }

  bool get isHorizontal =>
      this == SlideAnimDirection.left || this == SlideAnimDirection.right;
}

class SlideAnimWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Clip clipBehavior;

  // top, left, right, bottom alignment only:
  final SlideAnimDirection direction;
  final bool opened;
  final Decoration? decoration;
  final double from;

  const SlideAnimWrapper({
    super.key,
    required this.child,
    required this.duration,
    this.curve = Curves.easeInOut,
    this.direction = SlideAnimDirection.bottom,
    this.clipBehavior = Clip.none,
    this.from = 1,
    required this.opened,
    this.decoration,
  });

  @override
  State<SlideAnimWrapper> createState() => _SlideAnimWrapperState();
}

class _SlideAnimWrapperState extends State<SlideAnimWrapper> {
  bool opened = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opened = widget.opened;
      });
    });
  }

  @override
  void didUpdateWidget(covariant SlideAnimWrapper oldWidget) {
    if (oldWidget.opened != widget.opened) {
      setState(() {
        opened = widget.opened;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight * widget.from;
      final width = constraints.maxWidth * widget.from;
      return Align(
        alignment: widget.direction.alignment,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: widget.curve,
          clipBehavior: widget.clipBehavior,
          decoration: widget.decoration,
          height: widget.direction.isHorizontal
              ? null
              : opened
                  ? constraints.maxHeight
                  : 0,
          width: widget.direction.isHorizontal
              ? opened
                  ? constraints.maxWidth
                  : 0
              : null,
          child: Stack(
            children: [
              Positioned(
                  top: widget.direction._sideValue(SlideAnimDirection.top),
                  left: widget.direction._sideValue(SlideAnimDirection.left),
                  right: widget.direction._sideValue(SlideAnimDirection.right),
                  bottom:
                      widget.direction._sideValue(SlideAnimDirection.bottom),
                  child: SizedBox(
                      width: constraints.maxWidth + 1,
                      height: constraints.maxHeight + 1,
                      child: widget.child)),
            ],
          ),
        ),
      );
      return ClipRRect(
        clipBehavior: Clip.antiAlias,
        clipper: MyCustomClipper(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: widget.duration,
              curve: widget.curve,
              left: widget.direction == SlideAnimDirection.left
                  ? (opened ? 0 : -width)
                  : null,
              right: widget.direction == SlideAnimDirection.right
                  ? (opened ? 0 : -width)
                  : null,
              top: widget.direction == SlideAnimDirection.top
                  ? (opened ? 0 : -height)
                  : null,
              bottom: widget.direction == SlideAnimDirection.bottom
                  ? (opened ? 0 : -height)
                  : null,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: widget.child),
            ),
          ],
        ),
      );
    });
  }
}

class MyCustomClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    //   clip only bottom
    return RRect.fromRectAndCorners(
      Rect.fromLTWH(-50, -50, size.width + 100, size.height + 50),
      bottomLeft: const Radius.circular(20),
      bottomRight: const Radius.circular(20),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}
