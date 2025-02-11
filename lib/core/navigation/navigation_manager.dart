
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/environment_config.dart';
import '../../presentation/viewmodel/home_view_model.dart';
import '../../presentation/views/common/navigation/navigation_error_view.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/search/search_view.dart';
import '../../presentation/views/server_state/down_view.dart';
import '../../presentation/views/setttings/setting_view.dart';

class NavigationManager {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: "/",
    errorBuilder: (BuildContext context, GoRouterState state) {
      return NavigationErrorView();
    },
    redirect: (context, state) {
      // final isGoingToProfile = state.uri.path == '/profile';
      // if (isGoingToProfile && !isAuthenticated) return '/login';
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage(title: "title");
        },
        // onExit: (BuildContext context, GoRouterState state) {
        //   print("???");
        //   return true;
        // },
        routes: <RouteBase>[
          GoRoute(
            path: 'setting',
            name: AppRoutes.setting,
            builder: (BuildContext context, GoRouterState state) {
              return const SettingView();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/server-down',
        name: AppRoutes.serverDown,
        builder: (context, state) => ServerDown(),
      ),
      GoRoute(
        path: '/search',
        name: AppRoutes.search,
        builder: (context, state) {
          final controller = state.extra as HomeViewModel;
          return SearchView(controller: controller);
        },
      ),
    ],
  );
}