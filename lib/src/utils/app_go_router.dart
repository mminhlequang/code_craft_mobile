import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internal_core/internal_core.dart';

import '../presentation/home/cubit/home_cubit.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/splash/splash_screen.dart';
import '../presentation/introduction/introduction_screen.dart';
import '../presentation/auth/login_screen.dart';
import 'app_get.dart';

GlobalKey<NavigatorState> get appNavigatorKey =>
    findInstance<GlobalKey<NavigatorState>>();
bool get isAppContextReady => appNavigatorKey.currentContext != null;
BuildContext get appContext => appNavigatorKey.currentContext!;

class AppGoRouter {
  AppGoRouter._();

  static final AppGoRouter _instance = AppGoRouter._();

  static AppGoRouter get instance => _instance;

  void goToIntroduction() {
    if (isAppContextReady) {
      appContext.go('/introduction');
    }
  }

  void goToHome() {
    if (isAppContextReady) {
      appContext.go('/home');
    }
  }

  void goToLogin() {
    if (isAppContextReady) {
      appContext.go('/login');
    }
  }

  void goToSplash() {
    if (isAppContextReady) {
      appContext.go('/splash');
    }
  }
}

clearAllRouters([String? router]) {
  try {
    while (appContext.canPop() == true) {
      appContext.pop();
    }
  } catch (_) {}
  if (router != null) {
    appContext.pushReplacement(router);
  }
}

pushWidget(
    {required child,
    String? routeName,
    bool opaque = true,
    bool replacement = false}) {
  if (replacement) {
    return Navigator.of(appContext).pushReplacement(PageRouteBuilder(
      opaque: opaque,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      settings: RouteSettings(name: routeName),
    ));
  } else {
    return Navigator.of(appContext).push(PageRouteBuilder(
      opaque: opaque,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      settings: RouteSettings(name: routeName),
    ));
  }
}

// GoRouter configuration
final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: appNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/introduction',
      builder: (context, state) => const IntroductionScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeScreen(),
      ),
    ),
  ],
);
