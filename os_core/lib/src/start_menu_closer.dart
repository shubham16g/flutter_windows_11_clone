import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'controllers/desktop_overlay_controller.dart';

class StartMenuCloser extends StatelessWidget {
  final Widget? child;

  const StartMenuCloser({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (details) {
        context.read<DesktopOverlayController>().closeStartMenu();
      },
      child: child,
    );
  }
}
