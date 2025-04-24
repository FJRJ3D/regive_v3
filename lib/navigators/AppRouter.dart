import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regive_v3/navigators/TabBarWidget.dart';
import 'package:regive_v3/screens/FoundObjectsScreen.dart';
import 'package:regive_v3/screens/LoginScreen.dart';
import 'package:regive_v3/screens/OrdersScreen.dart';
import 'package:regive_v3/screens/MyRequestScreen.dart';
import 'package:regive_v3/screens/ProductDetailsScreen.dart';
import 'package:regive_v3/screens/RegisterScreen.dart';

class AppNavigator {
  late final GoRouter _router;

  AppNavigator._internal() {
    _router = GoRouter(
      initialLocation: '/',
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
        GoRoute(path: '/my-orders', builder: (context, state) => const MyRequestScreen()),
      ],
    );
  }

  static final AppNavigator _instance = AppNavigator._internal();

  factory AppNavigator() => _instance;

  GoRouter get router => _router;
}
