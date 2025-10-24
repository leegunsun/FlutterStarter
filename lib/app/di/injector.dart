import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/service/fcm/fcm_get_token_service.dart';
import '../../core/utils/appstate_utility.dart';
import '../../core/utils/notification_utility.dart';

part 'injector.g.dart';

@Riverpod()
Future<void> appStartUp(Ref ref) async {
  FcmTokenManager.init();
  NotificationUtility().initMessaging();
  AppStateCheckUtility.init();
}