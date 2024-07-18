import 'package:banana_challenge/providers/validate_token.dart';
import 'package:banana_challenge/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: const AuthScreen(),
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.slowMiddle).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/products',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: const ProductScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.linear).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      name: 'product-details',
      path: '/products/:id',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final String productId = state.pathParameters['id']!;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: ProductDetailScreen(productId),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.linear).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null || !await validateUserToken(token)) {
      if (state.path != '/') {
        const SnackBar(
          content: Text('You need to be logged in to access this page'),
        );
        return '/';
      }
    } else {
      if (state.path == '/') {
        return '/products';
      }
    }
    return null;
  },
);
