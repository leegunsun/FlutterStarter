import 'dart:collection';

import 'package:flutter/material.dart';
import '../../app/routes/navigation_manager.dart';
import '../widgets/common/dialogs/custom_toast.dart';

class ToastManager {
  static final GlobalKey<NavigatorState> navigatorKey = NavigationManager.navigatorKey;

  // 메시지 큐
  static final Queue<String> _messageQueue = Queue<String>();
  static bool _isShowing = false; // 현재 토스트 메시지가 표시 중인지 확인하는 플래그

  static void showToast(String message, {Duration duration = const Duration(seconds: 2)}) {
    _messageQueue.add(message);
    _showNextToast(duration);

  }

  static void _showNextToast(Duration duration) async {

    if (_isShowing || _messageQueue.isEmpty) {
      return;
    }

    _isShowing = true;

    OverlayEntry? _overlayEntry;
    final overlayState = navigatorKey.currentState?.overlay;

    if (overlayState == null) {
      debugPrint("❌ navigatorKey.currentState.overlay가 null입니다! 토스트 메시지를 표시할 수 없습니다.");
      return;
    }

    final message = _messageQueue.removeFirst();

    // ✅ 매번 새로운 GlobalKey 생성
    final GlobalKey<AnimatedOverlayEntryState> animatedOverlayKey = GlobalKey<AnimatedOverlayEntryState>();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: kBottomNavigationBarHeight + 50,
        left: 20.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOverlayEntry(
            key: animatedOverlayKey, // 새로운 키 사용
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(_overlayEntry);

    // 메시지 표시 후 대기
    await Future.delayed(duration);

    // 애니메이션 종료 후 제거
    await animatedOverlayKey.currentState?.dismiss();
    _overlayEntry.remove();
    _overlayEntry = null;

    _isShowing = false;

    // 다음 메시지가 있는지 확인하고 실행
    if (_messageQueue.isNotEmpty) {
      _showNextToast(duration);
    }
  }
}
