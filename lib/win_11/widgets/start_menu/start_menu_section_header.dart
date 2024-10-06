import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/utils/ui_utils.dart';

import '../../common_widgets/mini_button.dart';

class StartMenuSectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  const StartMenuSectionHeader({super.key, required this.title, required this.buttonText, this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style:
            FluentTheme.of(context).typography.subtitle?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        const Spacer(),
        MiniButton(
          onPressed: onButtonPressed,
          child: Row(
            children: [
              Text(buttonText,
                  style: FluentTheme.of(context).typography.caption),
              const SizedBox(width: 8),
              const Icon(FluentIcons.chevron_right)
            ],
          ),
        )
      ],
    ).pad(horizontal: 63, bottom: 10);
  }
}
