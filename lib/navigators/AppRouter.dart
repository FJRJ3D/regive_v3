import 'package:go_router/go_router.dart';
import 'package:regive_v3/navigators/TabBarWidget.dart';
import 'package:regive_v3/screens/LoginRegisterScreen.dart';
import 'package:regive_v3/screens/MainScreen.dart';

class AppNavigator {
  late final GoRouter _router;

  AppNavigator._internal() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginRegisterScreen(),
        ),
        GoRoute(path: '/main', builder: (context, state) => const TabBarWidget()),
      ],
    );
  }

  static final AppNavigator _instance = AppNavigator._internal();

  factory AppNavigator() => _instance;

  GoRouter get router => _router;
}
