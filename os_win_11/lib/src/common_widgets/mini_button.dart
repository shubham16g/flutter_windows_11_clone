import 'package:fluent_ui/fluent_ui.dart';

class MiniButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const MiniButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Button(
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
      ),
      onPressed: () {},
      child: IconTheme(
          data: FluentTheme.of(context).iconTheme.copyWith(size: 8),
          child: child),
    );
  }
}
