import 'package:fluent_ui/fluent_ui.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import 'widgets/start_menu/start_menu.dart';
import 'widgets/taskbar/taskbar.dart';

class Win11Builder extends StatelessWidget {
  final Map<String, App> apps;
  final List<String> fixedTaskbarApps;

  const Win11Builder(
      {super.key, required this.apps, required this.fixedTaskbarApps});


  @override
  Widget build(BuildContext context) {
    return OsBuilder(
      apps: apps,
      fixedTaskbarApps: fixedTaskbarApps,
      builder: (context) =>
          FluentApp(
            debugShowCheckedModeBanner: false,
            title: 'Windows 11 Clone',
            themeMode: context
                .watch<OsThemeController>()
                .themeMode,
            darkTheme: FluentThemeData(
              brightness: Brightness.dark,
              accentColor: Colors.blue,
              visualDensity: VisualDensity.standard,
            ),
            theme: FluentThemeData(
              accentColor: Colors.blue,
              visualDensity: VisualDensity.standard,
            ),
            home: OsScreen(
              desktop: const SizedBox(),
              taskbarBuilder: (context, alignment) => const Taskbar(),
              startMenuBuilder: (context, isOpened) =>
                  StartMenu(isStartMenuOpened: isOpened),
            ),
          ),
    );
  }
}
