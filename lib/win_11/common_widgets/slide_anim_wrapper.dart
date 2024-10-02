import 'package:flutter/material.dart';

enum SlideAnimDirection { top, left, right, bottom }

class SlideAnimWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  // top, left, right, bottom alignment only:
  final SlideAnimDirection direction;
  final bool opened;
  final double from;

  const SlideAnimWrapper({
    super.key,
    required this.child,
    required this.duration,
    this.curve = Curves.easeInOut,
    this.direction = SlideAnimDirection.bottom,
    this.from = 1,
    required this.opened,
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
