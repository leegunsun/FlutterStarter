
import 'package:dateapp/app/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/feature/home/view/home_view.dart';
import '../../presentation/feature/search/view/search_view.dart';
import '../../presentation/feature/server_state/view/down_view.dart';
import '../../presentation/feature/server_state/view/navigation_error_view.dart';
import '../../presentation/feature/setttings/view/setting_view.dart';

class NavigationManager {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.home.path,
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
            // navigatorKey: GlobalKey<NavigatorState>(), // 네비게이터 키 설정
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                builder: (context, state) => const MyHomePage(title: "Home"),
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: AppRoutes.setting.path,
                name: AppRoutes.setting.name,
                builder: (context, state) => const SettingView(),
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: AppRoutes.serverDown.path,
                name: AppRoutes.serverDown.name,
                builder: (context, state) => ServerDown(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.search.path,
        name: AppRoutes.search.name,
        builder: (context, state) {
          return SearchView();
        },
      ),
    ],
  );
}