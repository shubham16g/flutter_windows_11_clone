import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_button.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/mini_button.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/slide_anim_wrapper.dart';
import 'package:flutter_windows_11_clone/win_11/widgets/start_menu/start_menu_pinned_section.dart';
import 'package:flutter_windows_11_clone/win_11/widgets/start_menu/start_menu_recommended_section.dart';

import '../common_widgets/app_background.dart';
import '../common_widgets/glass_blur_bg.dart';
import 'start_menu/start_menu.dart';

class StartMenuWrapper extends StatelessWidget {
  final bool isStartMenuOpened;

  const StartMenuWrapper({super.key, required this.isStartMenuOpened});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenSize.height - 48;
    final double height = screenHeight > 726 ? 726 : screenHeight;
    return Center(
      child: SizedBox(
        width: 642,
        height: height,
        child: SlideAnimWrapper(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            opened: isStartMenuOpened,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 13),
              child: AppBackground(
                  borderColor: context.osColor.taskbarBorder,
                  isFocused: true,
                  isFullScreen: false,
                  backgroundColor: Colors.transparent,
                  child: const GlassBlurBg(
                    child: StartMenu(),
                  )),
            )),
      ),
    );
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      left: 0,
      right: 0,
      bottom: isStartMenuOpened ? 0 : -height - 13 - 20,
      child: Center(
        child: Container(
          width: 642,
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 13),
          child: AppBackground(
              borderColor: context.osColor.taskbarBorder,
              isFocused: true,
              isFullScreen: false,
              backgroundColor: Colors.transparent,
              child: const GlassBlurBg(
                child: StartMenu(),
              )),
        ),
      ),
    );
  }
}
