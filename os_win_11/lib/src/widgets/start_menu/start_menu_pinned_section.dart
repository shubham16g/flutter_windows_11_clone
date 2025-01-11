import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:os_win_11/src/utils/ui_utils.dart';
import 'package:os_win_11/src/widgets/start_menu/start_menu_section_header.dart';

import '../../common_widgets/glass_button.dart';

class StartMenuPinnedSection extends StatelessWidget {
  const StartMenuPinnedSection({super.key});

  @override
  Widget build(BuildContext context) {
    const itemHeight = 84.0;
    return Column(
      children: [
        StartMenuSectionHeader(
          title: 'Pinned',
          buttonText: 'All apps',
          onButtonPressed: () {},
        ),
        SizedBox(
          height: itemHeight * 3,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 110, mainAxisExtent: itemHeight),
                  padding: EdgeInsets.zero,
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    return GlassButton.builder(
                      pressedScale: 0.85,
                      onPressed: () {},
                      builder: (context, isTapDown) => _buildTile(
                          context,
                          isTapDown,
                          'Edge',
                          SvgPicture.asset('assets/icons/edge_app.svg',
                              width: 38)),
                    );
                  },
                ).pad(horizontal: 33),
              ),
            ],
          ),
        ).pad(bottom: 33),
      ],
    );
  }

  Widget _buildTile(
      BuildContext context, bool isTapDown, String title, Widget icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedScale(
            scale: isTapDown ? 0.85 : 1,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
            child: icon),
        const SizedBox(height: 2),
        Text(
          title,
          style: FluentTheme.of(context).typography.caption,
        )
      ],
    );
  }
}
