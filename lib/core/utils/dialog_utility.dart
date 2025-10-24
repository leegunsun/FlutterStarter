import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/routes/navigation_manager.dart';

class DialogUtility {

  /// 다이얼로그 표시 함수
  static void short({required String title, required String message}) {

    final BuildContext? context = NavigationManager.navigatorKey.currentContext;
    // final context = NavigationManager.navigatorKey.currentState?.overlay?.context;

    if (context == null) {
      debugPrint("❌ navigatorKey.currentState가 null 입니다! 다이얼로그를 띄울 수 없습니다.");
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("닫기"),
          ),
        ],
      ),
    );
  }

  /// ios 스타일 다이얼로그 표시 함수
  static void shortIOS({required Widget child}) {

    final BuildContext? context = NavigationManager.navigatorKey.currentContext;

    if (context == null) {
      debugPrint("❌ navigatorKey.currentState가 null 입니다! 다이얼로그를 띄울 수 없습니다.");
      return;
    }

    Navigator.of(context, rootNavigator: true).push(
      CupertinoSheetRoute(
        builder: (context) => child,
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove()); // 2초 후 제거
  }
}