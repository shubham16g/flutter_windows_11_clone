import 'package:go_router/go_router.dart';
import 'package:settings_app_win_11/src/pages/home_page.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
]);
