import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temp_package_name/src/presentation/home/cubit/home_cubit.dart';

import '../presentation/home/home_screen.dart';
import '../presentation/page1/bloc/page1_bloc.dart';
import '../presentation/page1/page1_screen.dart';
import '../presentation/page2/page2_screen.dart';
import '../presentation/splash/splash_screen.dart';
import '../presentation/introduction/introduction_screen.dart';
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
      appContext.go('/');
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
  navigatorKey: appNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'introduction',
      path: '/introduction',
      builder: (context, state) => const IntroductionScreen(),
    ),
    GoRoute(
      name: '/',
      path: '/',

      /// Example register new [bloc] using at [homescreen]
      builder: (context, state) => BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: 'page1',
          path: 'page1',

          /// Example register new [bloc] using at [Page1Screen]
          builder: (context, state) => BlocProvider(
            create: (context) => Page1Bloc(),
            child: const Page1Screen(),
          ),
        ),
        GoRoute(
          name: 'page2',
          path: 'page2',
          builder: (context, state) => const Page2Screen(),
        ),
      ],
    ),
  ],
);
