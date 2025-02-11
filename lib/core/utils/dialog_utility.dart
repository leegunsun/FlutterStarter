import 'package:flutter/material.dart';

class DialogUtility {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void showCustomDialog({required String title, required String message}) {
    if (navigatorKey.currentState == null) {
      debugPrint("NavigatorState가 존재하지 않습니다.");
      return;
    }

    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
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