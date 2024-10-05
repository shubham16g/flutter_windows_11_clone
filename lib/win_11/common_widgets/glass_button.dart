import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/apps/apps.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';

// todo zoom out hover exit effect
class GlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget Function(BuildContext context, bool isTapDown)? builder;
  final Widget? child;
  final double pressedScale;
  final bool isFocused;
  final bool isActive;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool showOutline;

  const GlassButton.builder(
      {super.key,
      this.onPressed,
      required Widget Function(BuildContext context, bool isTapDown)
          this.builder,
      this.isFocused = false,
      this.isActive = false,
      this.pressedScale = 0.7,
      this.showOutline = true,
      this.width,
      this.height,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6)})
      : child = null;

  const GlassButton(
      {super.key,
      this.onPressed,
      required Widget this.child,
      this.isFocused = false,
      this.isActive = false,
      this.pressedScale = 0.7,
      this.showOutline = true,
      this.width,
      this.height,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6)})
      : builder = null;

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool isHovered = false;
  bool isTapDown = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor;
    final Color tapDownColor;
    final Color hoverOutlineColor;
    final Color tapDownOutlineColor;
    if (widget.isActive) {
      hoverColor = Colors.blue.withOpacity(context.isDark ? 0.1 : 0.6);
      tapDownColor = Colors.blue.withOpacity(context.isDark ? 0.06 : 0.4);
      hoverOutlineColor = Colors.blue.withOpacity(0.15);
      tapDownOutlineColor = Colors.blue.withOpacity(0.3);
    } else {
      hoverColor = Colors.white.withOpacity(context.isDark ? 0.1 : 0.6);
      tapDownColor = Colors.white.withOpacity(context.isDark ? 0.06 : 0.4);
      hoverOutlineColor = Colors.white.withOpacity(0.15);
      tapDownOutlineColor = Colors.white.withOpacity(0.3);
    }
    return MouseRegion(
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
            color: isTapDown
                ? tapDownColor
                : isHovered
                    ? hoverColor
                    : widget.isFocused
                        ? tapDownColor
                        : Colors.white.withOpacity(0),
            borderRadius: BorderRadius.circular(4),
            border: widget.showOutline
                ? Border.all(
                    color: isTapDown
                        ? tapDownOutlineColor
                        : isHovered
                            ? hoverOutlineColor
                            : widget.isFocused
                                ? tapDownColor
                                : Colors.white.withOpacity(0),
                    width: 0.5)
                : null,
          ),
          child: widget.child ?? widget.builder?.call(context, isTapDown),
        ),
      ),
    );
  }
}
