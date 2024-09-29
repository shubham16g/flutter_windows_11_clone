import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/app/widgets/appbar_corner_buttons.dart';
import 'package:provider/provider.dart';

import '../../controllers/app_controller.dart';

class WinAppBar extends StatelessWidget {
  final Widget? child;
  final double appbarHeight;
  final Widget? leading;
  final bool isDark;

  const WinAppBar({
    super.key,
    this.child,
    this.appbarHeight = 40,
    this.leading,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appbarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: GestureDetector(
              onDoubleTap: () {
                context.read<AppController>().toggleFullScreen();
              },
              child: child,
            ),
          ),
          AppbarCornerButtons(isDark: isDark),
        ],
      ),
    );
  }
}
