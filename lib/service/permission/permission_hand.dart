import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PerMissionHandle {

  Future<PermissionStatus> _checkPermission() async {
    final PermissionStatus status = await Permission.notification.status;
    return status;
  }

  Future<void> requestPermission(BuildContext context) async {

    bool _isGranted = await _checkPermission().isGranted;

    if(_isGranted) {
      return;
    }

    final PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("알림 권한이 허용되었습니다.")),
      );
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("알림 권한이 거부되었습니다.")),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}