import 'package:fluent_ui/fluent_ui.dart';

class GlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget Function(BuildContext context, bool isTapDown) builder;
  final double pressedScale;
  final bool isFocused;

  const GlassButton(
      {super.key,
      this.onPressed,
      required this.builder,
      this.isFocused = false,
      this.pressedScale = 0.7});

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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isHovered && widget.isFocused
                  ? 0.08
                  : widget.isFocused
                      ? 0.06
                      : isHovered
                          ? 0.05
                          : 0),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: const Color(0xFFFFFFFF)
                      .withOpacity(isHovered && widget.isFocused
                          ? 0.15
                          : widget.isFocused
                              ? 0.1
                              : isHovered
                                  ? 0.08
                                  : 0),
                  width: 0.5),
            ),
            alignment: Alignment.center,
            child: widget.builder(context, isTapDown),
          ),
        ),
      ),
    );
  }
}
