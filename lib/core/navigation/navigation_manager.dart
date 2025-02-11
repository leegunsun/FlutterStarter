
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
      ShellRoute(
          builder: (context, state, child) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, result) {

              },
              child: Scaffold(
                body: child,
                appBar: AppBar(),
                bottomNavigationBar: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                    BottomNavigationBarItem(icon: Icon(Icons.dangerous), label: 'serverDown'),
                  ],
                  onTap: (index) {
                    if (index == 0) context.goNamed(AppRoutes.home);
                    if (index == 1) context.goNamed(AppRoutes.search);
                    if (index == 2) context.goNamed(AppRoutes.serverDown);
                  },
                ),
              ),
            );
          },
        routes: [
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
          path: '/search',
          name: AppRoutes.search,
          builder: (context, state) {
            final controller = state.extra as HomeViewModel;
            return SearchView(controller: controller);
          },
        ),
          GoRoute(
            path: '/server-down',
            name: AppRoutes.serverDown,
            builder: (context, state) => ServerDown(),
          ),
      ]),
    ],
  );
}