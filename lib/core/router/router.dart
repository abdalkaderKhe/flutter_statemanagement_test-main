import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/router/router_notifier.dart';
import 'package:state_management_test/feature/auth/view/login_view.dart';
import 'package:state_management_test/feature/auth/view/signup_view.dart';
import 'package:state_management_test/feature/home/view/home_view.dart';

final _key = GlobalKey<NavigatorState>();

enum AppRoute {login,home,signup}

final routerProvider = Provider<GoRouter>((ref) {

  final routerNotifier = ref.read(routerNotifierProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: '/${AppRoute.login.name}',
    refreshListenable: routerNotifier,

    redirect: (BuildContext context, GoRouterState state)
    {

      bool pushSingUp = routerNotifier.pushSingUp;
      bool pushHome = routerNotifier.pushHome;
      bool pushLogin = routerNotifier.pushLogin;

      if(pushHome)
      {
         return '/${AppRoute.home.name}';
      }

      if(pushLogin)
      {
        return '/${AppRoute.login.name}';
      }

      if(pushSingUp)
      {
        return '/${AppRoute.signup.name}';
      }
      return null;

    },

    routes:
    [
      GoRoute(
        path: '/${AppRoute.login.name}',
        name: AppRoute.login.name,
        builder: (context, state)
        {
          return const LoginView();
        },
      ),
      GoRoute(
        path: '/${AppRoute.signup.name}',
        name: AppRoute.signup.name,
        builder: (context, state)
        {
          return const SignUpView();
        },
      ),
      GoRoute(
        path: '/${AppRoute.home.name}',
        name: AppRoute.home.name,
        builder: (context, state)
        {
          return const HomeView();
        },
      ),
    ],

  );
},


);