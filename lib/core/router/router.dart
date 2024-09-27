import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/common/providers/auth/auth_provider.dart';
import 'package:news_app/core/constants/enums.dart';
import 'package:news_app/features/auth/presentation/pages/login_page.dart';
import 'package:news_app/features/auth/presentation/pages/signup_page.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/presentation/pages/article_page.dart';
import 'package:news_app/features/news/presentation/pages/news_wall_page.dart';
import 'package:provider/provider.dart';

abstract interface class AppRouter {
  static final router = GoRouter(
    initialLocation: '/signin',
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(child: Text('Page Not Found')),
      );
    },
    redirect: _guard,
    routes: [
      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const LoginPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
      GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
                child: const NewsWallPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return CupertinoPageTransition(
                    primaryRouteAnimation: animation,
                    secondaryRouteAnimation: secondaryAnimation,
                    linearTransition: true,
                    child: child,
                  );
                });
          },
          routes: [
            GoRoute(
              path: 'article',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: ArticlePage(article: state.extra as ArticleEntity),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return CupertinoPageTransition(
                      primaryRouteAnimation: animation,
                      secondaryRouteAnimation: secondaryAnimation,
                      linearTransition: true,
                      child: child,
                    );
                  },
                );
              },
            ),
          ]),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const SignupPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
    ],
  );

  static String? _guard(BuildContext context, GoRouterState state) {
    AuthStatus isAuthenticated = context.read<AuthStatusProvider>().status;
    if (state.matchedLocation == '/signup' &&
        isAuthenticated == AuthStatus.unauthenticated) {
      return null;
    }
    if (state.matchedLocation == '/signin' &&
        isAuthenticated == AuthStatus.unauthenticated) {
      return null;
    }

    if (isAuthenticated == AuthStatus.authenticated &&
        state.matchedLocation == '/signin' || isAuthenticated == AuthStatus.authenticated &&
        state.matchedLocation == '/signup') {
      return '/';
    }

    if (isAuthenticated == AuthStatus.unauthenticated) {
      return '/signin';
    }
    return null;
  }
}
