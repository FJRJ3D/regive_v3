import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/navigators/TabBarWidget.dart';
import 'package:regive_v3/providers/AuthNotifier.dart';
import 'package:regive_v3/screens/FoundObjectsScreen.dart';
import 'package:regive_v3/screens/LoginScreen.dart';
import 'package:regive_v3/screens/OrdersScreen.dart';
import 'package:regive_v3/screens/MyRequestScreen.dart';
import 'package:regive_v3/screens/ProductDetailsScreen.dart';
import 'package:regive_v3/screens/RegisterScreen.dart';
import 'package:regive_v3/screens/user_additional_screen/HelpAndSupportScreen.dart';
import 'package:regive_v3/screens/user_additional_screen/UserChangeDataScreen.dart';
import 'package:regive_v3/screens/user_additional_screen/UserDataScreen.dart';

class AppNavigator {
  late final GoRouter _router;
  AppNavigator._internal() {
    _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(path: '/main', builder: (context, state) => const TabBarWidget()),
        GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
        GoRoute(
          path: '/product-details',
          builder: (context, state) => ProductDetailsScreen(),
        ),
        GoRoute(path: '/search', builder: (context, state) => const FoundObjectsScreen()),
        GoRoute(
          path: '/orders',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const OrdersScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            opaque: false,
            barrierColor: Colors.transparent,
          ),
        ),
        GoRoute(path: '/my-orders', builder: (context, state) => const MyRequestScreen(),
        ),
        GoRoute(path: '/user-data', builder: (context, state) => const UserDataScreen(),
        ),
        GoRoute(path: '/change-data', builder: (context, state) => const UserChangeDataScreen(),
        ),
        GoRoute(path: '/support', builder: (context, state) => const HelpAndSupportScreen(),
        ),
      ],

      redirect: (BuildContext context, GoRouterState state) {
        final user = FirebaseAuth.instance.currentUser;
        final loggingIn = state.matchedLocation == '/';

        if (user == null) {
          return loggingIn ? null : '/';
        } else {
          if (loggingIn) return '/main';
          return null;
        }
      },

      refreshListenable: AuthNotifier(),
    );
  }

  static final AppNavigator _instance = AppNavigator._internal();

  factory AppNavigator() => _instance;

  GoRouter get router => _router;
}
