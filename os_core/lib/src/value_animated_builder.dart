import 'package:flutter/material.dart';

class ValueAnimatedBuilder extends ImplicitlyAnimatedWidget {
  /// Creates a container that animates its parameters implicitly.
  const ValueAnimatedBuilder({
    super.key,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.builder,
    super.curve,
    required super.duration,
    super.onEnd,
  });

  final double top;
  final double left;
  final double width;
  final double height;
  final Widget Function(BuildContext context, double top, double left,
      double width, double height) builder;

  @override
  AnimatedWidgetBaseState<ValueAnimatedBuilder> createState() =>
      _ValueAnimatedBuilderState();
}

class _ValueAnimatedBuilderState
    extends AnimatedWidgetBaseState<ValueAnimatedBuilder> {
  Tween<double>? _top;
  Tween<double>? _left;
  Tween<double>? _width;
  Tween<double>? _height;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _top = visitor(_top, widget.top,
        (dynamic top) => Tween<double>(begin: top as double)) as Tween<double>?;
    _left = visitor(_left, widget.left,
            (dynamic left) => Tween<double>(begin: left as double))
        as Tween<double>?;
    _width = visitor(_width, widget.width,
            (dynamic width) => Tween<double>(begin: width as double))
        as Tween<double>?;
    _height = visitor(_height, widget.height,
            (dynamic height) => Tween<double>(begin: height as double))
        as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.animation;
    return widget.builder(
      context,
      _top!.evaluate(animation),
      _left!.evaluate(animation),
      _width!.evaluate(animation),
      _height!.evaluate(animation),
    );
  }
}

class SingleValueAnimatedBuilder extends ImplicitlyAnimatedWidget {
  /// Creates a container that animates its parameters implicitly.
  const SingleValueAnimatedBuilder({
    super.key,
    required this.value,
    required this.builder,
    super.curve,
    required super.duration,
    super.onEnd,
  });

  final double value;
  final Widget Function(BuildContext context, double value) builder;

  @override
  AnimatedWidgetBaseState<SingleValueAnimatedBuilder> createState() =>
      _SingleValueAnimatedBuilderState();
}

class _SingleValueAnimatedBuilderState
    extends AnimatedWidgetBaseState<SingleValueAnimatedBuilder> {
  Tween<double>? _value;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _value = visitor(_value, widget.value,
        (dynamic value) => Tween<double>(begin: value as double)) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.animation;
    return widget.builder(
      context,
      _value!.evaluate(animation),
    );
  }
}
