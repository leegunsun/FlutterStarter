
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

import 'core/local_database/source/local_secure_source.dart';
import 'core/navigation/navigation_manager.dart';
import 'core/utils/appstate_utility.dart';
import 'core/utils/notification_utility.dart';
import 'firebase_options.dart';

import 'package:easy_localization/easy_localization.dart';

part 'core/service/fcm/fcm_service.dart';

void main() {
  runZonedGuarded(
        () async {
          WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
          FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
          await EnvironmentConfig.init(); // env 등록
          await EasyLocalization.ensureInitialized(); // 국제화
          await AppsflyerService.init(); // 디퍼드 딥링킹
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
          FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

          FlutterError.onError = (FlutterErrorDetails details) {
            FlutterError.presentError(details); // 콘솔 출력
            FirebaseCrashlytics.instance.recordFlutterFatalError(details);
          };

          runApp(ProviderScope(
            child: EasyLocalization(
                supportedLocales: [Locale('en', 'US'), Locale('ko', "KR")],
                fallbackLocale: const Locale('en', 'US'),
                path: EnvironmentConfig.constants.EASY_LOCAL_ASSET,
                child: const MyApp()),
          )
          );
    },
        (error, stackTrace) async {
          await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}

void showCustomToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50.0, // 위치 조정
      left: MediaQuery.of(context).size.width * 0.2,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(Duration(seconds: 2), () => overlayEntry.remove()); // 2초 후 제거
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
          _gcd = gcd;
      },
      onDeepLinkUpdate: (deepLinkData) {
          _deepLinkData = deepLinkData;
      },
    );
    final ImageConfiguration config = createLocalImageConfiguration(context, size: Size(200, 200));
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
