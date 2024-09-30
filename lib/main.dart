import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/win_11/widgets/start_menu.dart';
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
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Windows 11 Clone',
        themeMode: context.watch<OsThemeController>().themeMode,
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          canvasColor: Colors.black,
          useMaterial3: true,
        ),
        home: OsScreen(
          fixedTaskbarApps: [
            FileExplorerApp(),
            SettingsApp(),
          ],
          startMenuBuilder: (context, isStartMenuOpened) =>
              StartMenu(isStartMenuOpened: isStartMenuOpened),
          taskBar: const Taskbar(),
        ),
      ),
    );
  }
}
