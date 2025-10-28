import 'dart:io';
import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';

import '../../app/routes/navigation_routes.dart';
import '../../data/remote/network/status_api.dart';
import '../../data/remote/network/model/appstate_model.dart';
import '../../app/routes/navigation_manager.dart';
import 'dialog_utility.dart';

class AppStateCheckUtility {
 static PackageInfo? packageInfo;

 static Future<void> init () async {
   packageInfo = await PackageInfo.fromPlatform();
   handleAppStatusNavigation(await StatusApi().mockResult());
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
     NavigationManager.router.goNamed(AppRoutes.home.name);
     return;
   }

   // 2) 앱 버전 비교
   bool _isVersionOlder = isVersionOlder(thisAppVersion: thisAppVersion, serverAppVersion: status.currentVersion);

   // ✅ 앱 버전이 서버 버전보다 낮을 때만 업데이트 로직 실행
   if (_isVersionOlder) {
     if (status.isForcedUpdate) {
       // ✅ 강제 업데이트일 경우: '강제 업데이트 화면'으로 이동
       NavigationManager.router.goNamed(AppRoutes.setting.name);
       return;
     } else {
       // ✅ 버전이 낮지만 강제 업데이트가 아닐 경우: 다이얼로그만 표기함
       DialogUtility.short(title: "버전 체크", message: "현재 버전이 낮습니다.");
     }
   }
 }

 static void handleAppStatusNavigation (AppStatus status) {

   String thisAppVersion = packageInfo?.version ?? "";

   if(Platform.isAndroid) {
     _handleAppStatusNavigation(status:status, thisAppVersion: thisAppVersion);
   } else if (Platform.isIOS) {
     _handleAppStatusNavigation(status:status, thisAppVersion: thisAppVersion);
   } else {
     NavigationManager.router.go(AppRoutes.notFound.name);
   }
 }
}