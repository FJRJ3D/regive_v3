import 'package:go_router/go_router.dart';
import 'package:regive_v3/navigators/TabBarWidget.dart';
import 'package:regive_v3/screens/ProductDetailsScreen.dart';
import 'package:regive_v3/view_models/ProductWithUser.dart';

class AppNavigator {
  late final GoRouter _router;

  AppNavigator._internal() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => TabBarWidget(),
          routes: [
            GoRoute(
              path: '/product-details',
              builder: (context, state) => ProductDetailsScreen(),
            ),
          ],
        ),
      ],
    );
  }

  static final AppNavigator _instance = AppNavigator._internal();

  factory AppNavigator() => _instance;

  GoRouter get router => _router;
}
