import 'package:fluent_ui/fluent_ui.dart';

class GlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget Function(BuildContext context, bool isTapDown) builder;
  final double pressedScale;
  final bool isFocused;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool showOutline;

  const GlassButton(
      {super.key,
      this.onPressed,
      required this.builder,
      this.isFocused = false,
      this.pressedScale = 0.7,
      this.showOutline = true,
      this.width,
      this.height,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6)});

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool isHovered = false;
  bool isTapDown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              isTapDown = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              isTapDown = false;
            });
          },
          onTapCancel: () {
            setState(() {
              isTapDown = false;
            });
          },
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: widget.width,
            padding: widget.padding,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isHovered && widget.isFocused
                  ? 0.08
                  : widget.isFocused
                      ? 0.06
                      : isHovered
                          ? 0.05
                          : 0),
              borderRadius: BorderRadius.circular(4),
              border: widget.showOutline ? Border.all(
                  color: const Color(0xFFFFFFFF)
                      .withOpacity(isHovered && widget.isFocused
                          ? 0.15
                          : widget.isFocused
                              ? 0.1
                              : isHovered
                                  ? 0.08
                                  : 0),
                  width: 0.5) : null,
            ),
            child: widget.builder(context, isTapDown),
          ),
        ),
      ),
    );
  }
}
