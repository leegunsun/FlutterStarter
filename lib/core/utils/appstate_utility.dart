import 'dart:io';
import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';

import '../api/status/status_api.dart';
import '../models/appstate/appstate_model.dart';
import '../navigation/navigation_manager.dart';
import 'dialog_utility.dart';

class AppStateCheckUtility {
 static PackageInfo? packageInfo;

 static Future<void> init () async {
   packageInfo = await PackageInfo.fromPlatform();
   await handleAppStatusNavigation(await StatusApi().mockResult());
 }

 /// 현재 버전이 요구되는 버전보다 낮은지 확인하는 함수
 static bool isVersionOlder({required String thisAppVersion, required String serverAppVersion}) {
   try {
     final currentParts = thisAppVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();
     final requiredParts = serverAppVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

     final length = max(currentParts.length, requiredParts.length);
     for (var i = 0; i < length; i++) {
       final currentPart = i < currentParts.length ? currentParts[i] : 0;
       final requiredPart = i < requiredParts.length ? requiredParts[i] : 0;

       if (currentPart < requiredPart) return true;
       if (currentPart > requiredPart) return false;
     }
     return false; // 동일한 경우
   } catch (e) {
     return false; // 예외 발생 시 기본값 (업데이트 필요 없음)
   }
 }

 static void _handleAppStatusNavigation({
       required AppStatus status,
   required String thisAppVersion}) {
   // 1) 서버 점검 상태가 우선
   if (status.isServerMaintenance) {
     NavigationManager.router.go("/home");
     return;
   }

   // 2) 앱 버전 비교
   bool _isVersionOlder = isVersionOlder(thisAppVersion: thisAppVersion, serverAppVersion: status.currentVersion);

   // ✅ 앱 버전이 서버 버전보다 낮을 때만 업데이트 로직 실행
   if (_isVersionOlder) {
     if (status.isForcedUpdate) {
       // ✅ 강제 업데이트일 경우: '강제 업데이트 화면'으로 이동
       NavigationManager.router.go("/setting2");
       return;
     } else {
       // ✅ 버전이 낮지만 강제 업데이트가 아닐 경우: 다이얼로그만 표기함 (지금은 테스트를 위해서 프린트 메서드 사용)
       // showDialog(context: MyApp.navigatorKey.currentContext!, builder: (context) {
       //   return Container(
       //     width: 100,
       //     height: 100,
       //     color: Colors.redAccent,
       //   );
       // });
       // DialogUtility.showCustomDialog(title: "title", message: "message");
     }
   }

   // 3) 정상 화면(홈 화면)으로 이동
   NavigationManager.router.go("/ss");
 }

 static Future<void> handleAppStatusNavigation (AppStatus status) async {

   String thisAppVersion = packageInfo?.version ?? "";

   if(Platform.isAndroid) {
     _handleAppStatusNavigation(status:status, thisAppVersion: thisAppVersion);
   } else if (Platform.isIOS) {
     _handleAppStatusNavigation(status:status, thisAppVersion: thisAppVersion);
   } else {
     NavigationManager.router.go("not Sup platform");
   }
 }
}