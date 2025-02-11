
import 'package:dateapp/core/service/fcm/fcm_get_token_service.dart';
import 'package:dateapp/config/environment_config.dart';
import 'package:dateapp/core/service/onelink/appsflyer_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/navigation/navigation_manager.dart';
import 'core/utils/appstate_utility.dart';
import 'core/utils/dialog_utility.dart';
import 'core/utils/notification_utility.dart';
import 'firebase_options.dart';

import 'package:easy_localization/easy_localization.dart';

part 'core/service/fcm/fcm_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await EnvironmentConfig.init();
  try {
    await AppsflyerService.init();
  } catch (e) {
    print(e);
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ko', "KR")],
      fallbackLocale: const Locale('en', 'US'),
      path: EnvironmentConfig.constants.EASY_LOCAL_ASSET,
      child: const MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationUtility().initMessaging();
    AppsflyerService.afStart(
      onGcdUpdate: (gcd) {
        setState(() {
          _gcd = gcd;
        });
      },
      onDeepLinkUpdate: (deepLinkData) {
        setState(() {
          _deepLinkData = deepLinkData;
        });
      },
    );
    FlutterNativeSplash.remove();
    FcmTokenManager.init();
    AppStateCheckUtility.init();
  }

  Map _deepLinkData = {};
  Map _gcd = {};
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: ProviderScope(
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          routerConfig: NavigationManager.router,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
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
      ),
    );
  }
}
