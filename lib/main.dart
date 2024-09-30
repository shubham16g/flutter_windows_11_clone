import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/widgets/start_menu.dart';
import 'package:flutter_windows_11_clone/os/widgets/taskbar.dart';
import 'package:os_core/os_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // ensure
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('os');
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
          startMenuBuilder: (context, isStartMenuOpened) =>
              StartMenu(isStartMenuOpened: isStartMenuOpened),
          taskBar: Taskbar(),
        ),
      ),
    );
  }
}
