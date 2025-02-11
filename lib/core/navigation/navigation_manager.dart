
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/viewmodel/home_view_model.dart';
import '../../presentation/views/common/navigation/navigation_error_view.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/search/search_view.dart';
import '../../presentation/views/server_state/down_view.dart';
import '../../presentation/views/setttings/setting_view.dart';

class NavigationManager {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    errorBuilder: (BuildContext context, GoRouterState state) {
      return NavigationErrorView();
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage(title: "title");
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'setting',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingView();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/server-down',
        builder: (context, state) => ServerDown(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) {
          final controller = state.extra as HomeViewModel;
          return SearchView(controller: controller);
        },
      ),
    ],
  );
}