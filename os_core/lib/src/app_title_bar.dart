import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/app_controller.dart';

class AppTitleBar extends StatelessWidget {
  final Widget? child;
  final double appbarHeight;
  final Widget? leading;
  final Widget? trailing;

  const AppTitleBar({
    super.key,
    this.child,
    this.appbarHeight = 40,
    this.leading, this.trailing,
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
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
