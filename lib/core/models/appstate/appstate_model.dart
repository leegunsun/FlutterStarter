import 'package:json_annotation/json_annotation.dart';

part 'appstate_model.g.dart';

@JsonSerializable()
class AppStatus {

  final String currentVersion;
  final bool isForcedUpdate;      // 강제 업데이트 여부
  final bool isServerMaintenance; // 서버 점검 여부

  AppStatus({
    required this.currentVersion,
    required this.isForcedUpdate,
    required this.isServerMaintenance,
  });

  factory AppStatus.fromJson (Map<String, dynamic> json) => _$AppStatusFromJson(json);
  Map<String,dynamic> toJson() => _$AppStatusToJson(this);
}

