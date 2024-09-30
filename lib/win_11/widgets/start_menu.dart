import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';
import 'package:flutter_windows_11_clone/win_11/colors/os_extension_on_colors.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/glass_button.dart';
import 'package:flutter_windows_11_clone/win_11/common_widgets/mini_button.dart';

import '../common_widgets/app_background.dart';
import '../common_widgets/glass_blur_bg.dart';

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormBox(
          placeholder: 'Search for apps, settings, and documents',
        ).pad(all: 33),
        Row(
          children: [
            Text('Pinned',
                style: FluentTheme.of(context).typography.subtitle?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
            const Spacer(),
            MiniButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text('All apps',
                      style: FluentTheme.of(context).typography.caption),
                  const SizedBox(width: 8),
                  const Icon(FluentIcons.chevron_right)
                ],
              ),
            )
          ],
        ).pad(horizontal: 63, bottom: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 110, childAspectRatio: 96 / 84),
          padding: EdgeInsets.zero,
          itemCount: 18,
          itemBuilder: (context, index) {
            return GlassButton(
              pressedScale: 0.85,
              onPressed: () {},
              builder: (context, isTapDown) => _buildTile(
                  context,
                  isTapDown,
                  'Edge',
                  SvgPicture.asset('assets/icons/edge_app.svg', width: 38)),
            );
          },
        ).pad(horizontal: 33, bottom: 33),
        Row(
          children: [
            Text('Recommended',
                style: FluentTheme.of(context).typography.subtitle?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            const Spacer(),
            MiniButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text('More',
                      style: FluentTheme.of(context).typography.caption),
                  const SizedBox(width: 8),
                  const Icon(FluentIcons.chevron_right)
                ],
              ),
            )
          ],
        ).pad(horizontal: 63, bottom: 10),
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

class StartMenuWrapper extends StatelessWidget {
  final bool isStartMenuOpened;

  const StartMenuWrapper({super.key, required this.isStartMenuOpened});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenSize.height - 48;
    final double height = screenHeight - 26 > 726 ? 726 : screenHeight - 26;
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
