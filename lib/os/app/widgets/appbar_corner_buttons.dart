import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/colors/os_extension_on_colors.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

class AppbarCornerButtons extends StatelessWidget {
  final bool isDark;

  const AppbarCornerButtons({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final appController = context.watch<AppController>();
    final iconColor = appController.isFocused
        ? context.getOsColor(isDark: isDark).iconColor
        : context.getOsColor(isDark: isDark).iconColorUnFocus;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _button(
            Icon(
              Icons.minimize,
              size: 16,
              color: iconColor,
            ), () {
          appController.toggleMinimizeMaximize();
        }),
        _button(
            appController.isFullScreen
                ? Transform.rotate(
                    angle: 3.14,
                    child: Icon(
                      Icons.filter_none,
                      size: 13,
                      color: iconColor,
                    ))
                : Icon(
                    Icons.crop_square,
                    size: 16,
                    color: iconColor,
                  ), () {
          appController.toggleFullScreen();
        }),
        _button(
            Icon(
              Icons.close,
              size: 16,
              color: iconColor,
            ), () {
          appController.closeApp();
        }, splashColor: Colors.red),
      ],
    );
  }

  Widget _button(Widget icon, VoidCallback onTap, {Color? splashColor}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        overlayColor:
            splashColor != null ? WidgetStatePropertyAll(splashColor) : null,
        child: Container(
          width: 40,
          height: 30,
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}
