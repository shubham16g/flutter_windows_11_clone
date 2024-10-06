import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';

import '../../common_widgets/glass_button.dart';
import 'start_menu_section_header.dart';

class StartMenuRecommendedSection extends StatelessWidget {
  const StartMenuRecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    const itemHeight = 56.0;
    return Column(
      children: [
        StartMenuSectionHeader(
          title: 'Recommended',
          buttonText: 'More',
          onButtonPressed: () {},
        ),
        SizedBox(
          height: itemHeight * 2,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: itemHeight, crossAxisSpacing: 16),
                  padding: const EdgeInsets.only(left: 10),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GlassButton(
                      padding: EdgeInsets.zero,
                      pressedScale: 0.85,
                      onPressed: () {},
                      child: ListTile(
                        leading:
                            SvgPicture.asset('assets/icons/edge_app.svg', width: 38),
                        title: Text('Edge',
                            style: FluentTheme.of(context).typography.caption),
                        subtitle: Text('Microsoft Corporation',
                            style: FluentTheme.of(context).typography.caption?.copyWith(
                                color: context.osColor.textSecondary,
                                fontWeight: FontWeight.w400)),
                      ),
                    );
                  },
                ).pad(horizontal: 33, bottom: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
