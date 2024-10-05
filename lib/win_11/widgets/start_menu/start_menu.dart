import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/win_11/widgets/start_menu/start_menu_footer.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_background.dart';
import '../../common_widgets/slide_anim_wrapper.dart';
import '../start_menu_wrapper.dart';
import 'start_menu_pinned_section.dart';
import 'start_menu_recommended_section.dart';

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isStartMenuOpened =
        context.watch<DesktopOverlayController>().isStartMenuOpened;
    final screenHeight = context.screenSize.height - 48;
    final double height = screenHeight > 726 ? 726 : screenHeight;
    return Align(
      alignment: Alignment.bottomCenter,
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
                  glassBlur: true,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        color: context.osColor.glassOverlay1,
                        child: Column(
                          children: [
                            TextFormBox(
                              placeholder:
                                  'Search for apps, settings, and documents',
                            ).pad(all: 33),
                            const StartMenuPinnedSection(),
                            const StartMenuRecommendedSection(),
                          ],
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                          color: context.osColor.glassOverlay2,
                          border: Border(
                              top: BorderSide(
                                  color: context.osColor.glassDivider,
                                  width: 1)),
                        ),
                        height: 64,
                        child: const StartMenuFooter(),
                      )
                    ],
                  )),
            )),
      ),
    );
  }
}
