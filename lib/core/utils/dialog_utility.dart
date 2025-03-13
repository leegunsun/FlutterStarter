import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigation/navigation_manager.dart';

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
}