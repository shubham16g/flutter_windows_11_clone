import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/win_11/widgets/start_menu_wrapper.dart';
import 'package:os_core/os_core.dart';
import 'package:provider/provider.dart';

import 'apps/apps.dart';
import 'apps/settings/settings_app.dart';
import 'win_11/widgets/taskbar.dart';

Future<void> main() async {
  // ensure
  WidgetsFlutterBinding.ensureInitialized();
  await OsCore.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OsBuilder(
      builder: (context) => FluentApp(
        debugShowCheckedModeBanner: false,
        title: 'Windows 11 Clone',
        themeMode: context.watch<OsThemeController>().themeMode,
        darkTheme: FluentThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.blue,
          visualDensity: VisualDensity.standard,
        ),
        theme:  FluentThemeData(
          accentColor: Colors.blue,
          visualDensity: VisualDensity.standard,

        ),
        home: OsScreen(
          fixedTaskbarApps: [
            FileExplorerApp(),
            SettingsApp(),
          ],
          startMenuBuilder: (context, isStartMenuOpened) =>
              StartMenuWrapper(isStartMenuOpened: isStartMenuOpened),
          taskBar: const Taskbar(),
        ),
      ),
    );
  }
}
