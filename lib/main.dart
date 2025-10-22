
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dateapp/config/environment_config.dart';
import 'package:dateapp/core/service/onelink/appsflyer_service.dart';
import 'package:dateapp/presentation/app.dart';
import 'package:dateapp/presentation/viewmodel/provider/app/app_provider.dart';
import 'package:dateapp/presentation/viewmodel/provider/app/conbin_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/local_database/source/local_secure_source.dart';
import 'firebase_options.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(appStartUpProvider, (prev, next) {
      next.whenData((_) {
        FlutterNativeSplash.remove();
      });
    });

    return const App();
  }
}
