import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/win_11/widgets/start_menu/start_menu_footer.dart';

import 'start_menu_pinned_section.dart';
import 'start_menu_recommended_section.dart';

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
              color: context.isDark
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.3),
              child: Column(
                children: [
                  TextFormBox(
                    placeholder: 'Search for apps, settings, and documents',
                  ).pad(all: 33),
                  const StartMenuPinnedSection(),
                  const StartMenuRecommendedSection(),
                ],
              ),
            )),
        Container(
          decoration: BoxDecoration(
            color: context.isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.transparent,
            border: Border(
                top: BorderSide(
                    color: context.osColor.taskbarBorder.withOpacity(0.1), width: 1)),
          ),
          height: 64,
          child: StartMenuFooter(),
        )
      ],
    );
  }


}