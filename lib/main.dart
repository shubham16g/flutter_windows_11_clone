import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_windows_11_clone/apps/youtube/youtube_app.dart';
import 'package:os_win_11/os_win_11.dart';

import 'apps/apps.dart';
import 'apps/settings/settings_app.dart';

Future<void> main() async {
  // ensure
  WidgetsFlutterBinding.ensureInitialized();
  await OsWin11.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Win11Builder(
      apps: {
        'files': FileExplorerApp(),
        'settings': SettingsApp(),
        'youtube': YoutubeApp(),
        'ecommerce': FileExplorerApp(),
      },
      fixedTaskbarApps: const ['files', 'settings', 'youtube'],
    );
  }
}
