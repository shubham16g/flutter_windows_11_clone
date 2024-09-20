import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/widgets/blend_mask.dart';

class GrainBlurBg extends StatelessWidget {

  const GrainBlurBg({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Stack(
          children: [
            Positioned.fill(
              child: BlendMask(
                blendMode: BlendMode.overlay,
                opacity: 1,    child: Container(
                    color: const Color(0xff888888).withOpacity(0.96)),
              ),
            ),
            Positioned.fill(child: Container(color: const Color(0xFF1F282E).withOpacity(.8))),
            Positioned.fill(
              child: Opacity(
                opacity: 0.02,
                child: Image.asset(
                  'assets/images/NoiseAsset_256.png',
                  repeat: ImageRepeat.repeat,
                  alignment: Alignment.topLeft,
                  // repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
