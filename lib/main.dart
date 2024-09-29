import 'package:flutter/material.dart';
import 'package:flutter_windows_11_clone/os/controllers/theme_controller.dart';
import 'package:flutter_windows_11_clone/os/main_page.dart';
import 'package:flutter_windows_11_clone/os/controllers/cursor_controller.dart';
import 'package:flutter_windows_11_clone/os/controllers/running_apps_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'os/controllers/wallpaper_controller.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (context) => CursorController()),
        ChangeNotifierProvider(create: (context) => RunningAppsController()),
        ChangeNotifierProvider(
            create: (context) => WallpaperWrapper(context.read())),
      ],
      builder: (context, w) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Windows 11 Clone',
        themeMode: context.watch<ThemeController>().themeMode,
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
        home: const MainPage(),
      ),
    );
  }
}
