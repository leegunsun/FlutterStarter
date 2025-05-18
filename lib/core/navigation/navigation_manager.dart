
import 'package:flutter/cupertino.dart';
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {

            },
            child: Scaffold(
              body: navigationShell, // 자동으로 상태가 유지되는 네비게이터
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (index) {
                  navigationShell.goBranch(index); // 탭 이동 시 상태 유지
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
                  BottomNavigationBarItem(icon: Icon(Icons.error), label: 'Server Down'),
                ],
              ),
            ),
          );
        },
        branches: [
          /// ✅ 각 탭을 `StatefulShellBranch`로 설정하여 상태 유지
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(), // 네비게이터 키 설정
            routes: [
              GoRoute(
                path: '/',
                name: AppRoutes.home,
                builder: (context, state) => const MyHomePage(title: "Home"),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: '/settings',
                name: AppRoutes.setting,
                builder: (context, state) => const SettingView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: '/server-down',
                name: AppRoutes.serverDown,
                builder: (context, state) => ServerDown(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/search',
        name: AppRoutes.search,
        builder: (context, state) {
          return SearchView();
        },
      ),
    ],
  );
}