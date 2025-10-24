import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/services/onelink/appsflyer_service.dart';
import 'routes/navigation_manager.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppsflyerService.afStart(
      onGcdUpdate: (gcd) {
        _gcd = gcd;
      },
      onDeepLinkUpdate: (deepLinkData) {
        _deepLinkData = deepLinkData;
      },
    );
  }

  Map _deepLinkData = {};
  Map _gcd = {};
  bool isLoggedIn = false;


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        routerConfig: NavigationManager.router,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
            },
          ),
          scaffoldBackgroundColor: Colors.purple[50],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurple,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
