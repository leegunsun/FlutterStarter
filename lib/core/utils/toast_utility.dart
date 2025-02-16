import 'package:flutter/material.dart';
import '../navigation/navigation_manager.dart';

part '../../presentation/widgets/custom_toast.dart';

class ToastManager {
  static final GlobalKey<NavigatorState> navigatorKey = NavigationManager.navigatorKey;
  static OverlayEntry? _overlayEntry;

  // GlobalKey를 생성하여 AnimatedOverlayEntry의 상태에 접근할 수 있게 합니다.
  static final GlobalKey<_AnimatedOverlayEntryState> _animatedOverlayKey = GlobalKey<_AnimatedOverlayEntryState>();


  static void showToast(String message, {Duration duration = const Duration(seconds: 2)}) {
    final overlayState = navigatorKey.currentState?.overlay;

    if (overlayState == null) {
      debugPrint("❌ navigatorKey.currentState.overlay가 null입니다! 토스트 메시지를 표시할 수 없습니다.");
      return;
    }

    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: kBottomNavigationBarHeight + 50,
        left: 20.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOverlayEntry(
            key: _animatedOverlayKey, // 여기서 GlobalKey를 할당합니다.
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

    overlayState.insert(_overlayEntry!);

    // 일정 시간 후 fade-out 효과를 위해 dismiss()를 호출한 후 OverlayEntry를 제거합니다.
    Future.delayed(duration, () async {
      await _animatedOverlayKey.currentState?.dismiss();
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}


