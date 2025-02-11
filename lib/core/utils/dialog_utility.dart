import 'package:flutter/material.dart';

import '../navigation/navigation_manager.dart';

class DialogUtility {

  /// 다이얼로그 표시 함수
  static Future<void> showCustomDialog({required String title, required String message}) async {

    final context = NavigationManager.navigatorKey.currentContext;
    // final context = NavigationManager.navigatorKey.currentState?.overlay?.context;

    if (context == null) {
      debugPrint("❌ navigatorKey.currentState가 null 입니다! 다이얼로그를 띄울 수 없습니다.");
      return;
    }

   await showDialog<void>(
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
}