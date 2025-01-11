import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../os_core.dart';

class StartMenuButtonBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, VoidCallback callback, bool isOpened) builder;

  const StartMenuButtonBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final desktopOverlayController = context.watch<DesktopOverlayController>();
    return builder(context, desktopOverlayController.toggleStartMenu,
        desktopOverlayController.isStartMenuOpened);
  }
}
