import 'package:go_router/go_router.dart';
import 'package:regive_v3/navigators/TabBarWidget.dart';
import 'package:regive_v3/screens/LoginScreen.dart';
import 'package:regive_v3/screens/RegisterScreen.dart';



class AppNavigator {
  late final GoRouter _router;

  AppNavigator._internal() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const LoginScreen(),
        // ),
        //=========================================================Poner bien, solo para pruebas
        GoRoute(
          path: '/',
          builder: (context, state) => const TabBarWidget(),
        ),
        //=========================================================Poner bien, solo para pruebas
        GoRoute(path: '/main', builder: (context, state) => const TabBarWidget()),
        GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      ],
    );
  }

  static final AppNavigator _instance = AppNavigator._internal();

  factory AppNavigator() => _instance;

  GoRouter get router => _router;
}
