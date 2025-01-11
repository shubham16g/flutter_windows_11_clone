import 'package:go_router/go_router.dart';
import 'package:settings_app_win_11/src/pages/home_page.dart';
import 'package:settings_app_win_11/src/pages/theme_page.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', name: 'home', builder: (context, state) => const HomePage()),
  GoRoute(path: '/cartx', name: 'theme', builder: (context, state) => const ThemePage()),
]);
