import 'package:flutter/material.dart';

import '../../os_core.dart';

class BrightnessOverlay extends StatelessWidget {
  const BrightnessOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessController = OsBrightnessController.watch(context);
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: Tween<double>(begin: 0.9, end: 0)
            .transform(brightnessController.brightness / 100),
        duration: const Duration(milliseconds: 300),
        child: const ColoredBox(
          color: Colors.black,
        ),
      ),
    );
  }
}
