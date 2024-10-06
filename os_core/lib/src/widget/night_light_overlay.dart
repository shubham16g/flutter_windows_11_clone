import 'package:flutter/material.dart';
import 'package:os_core/src/value_animated_builder.dart';

import '../../os_core.dart';

class NightLightOverlay extends StatelessWidget {
  final Widget child;

  const NightLightOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final nightLightController = OsNightLightController.watch(context);
    // if (!nightLightController.isNightLightOn) {
    //   return const SizedBox();
    // }
    return SingleValueAnimatedBuilder(
        value: nightLightController.strength / 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, value) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.deepOrange.withOpacity(
                    nightLightController.isNightLightOn
                        ? Tween(begin: 0.0, end: 0.6).transform(value)
                        : 0),
                BlendMode.multiply),
            child: child,
          );
        });
  }
}

class BlendModeColor extends StatelessWidget {
  final Color color;
  final BlendMode blendMode;
  final Widget child;

  const BlendModeColor({
    super.key,
    required this.color,
    required this.blendMode,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, blendMode),
      child: child,
    );
  }
}
