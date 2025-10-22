import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/service/fcm/fcm_get_token_service.dart';
import '../../../../core/utils/appstate_utility.dart';
import '../../../../core/utils/notification_utility.dart';

part 'app_provider.g.dart';

@Riverpod()
Future<void> appProvider(Ref ref) async {
  NotificationUtility().initMessaging();
  FcmTokenManager.init();
  AppStateCheckUtility.init();
}